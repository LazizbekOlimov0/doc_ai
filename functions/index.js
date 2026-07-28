const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();

// ─────────────────────────────────────────────────────────
// askDocAiAgent — callable function
// ─────────────────────────────────────────────────────────
exports.askDocAiAgent = functions.https.onCall(async (data, context) => {
  const { patientMessage, patientId } = data;

  if (!patientMessage || !patientId) {
    throw new functions.https.HttpsError('invalid-argument', 'patientMessage and patientId required');
  }

  // Call Vertex AI Agent Builder
  const { DiscoveryEngineClient } = require('@google-cloud/discoveryengine');
  const client = new DiscoveryEngineClient();

  const projectId = 'doc-ai-antigravity';
  const location = 'us';
  const dataStoreId = 'doc-ai-clinical-data_1785072129919';
  const engineId = 'doc-ai-clinical-agent_1785072240894';

  const servingConfig = `projects/${projectId}/locations/${location}/collections/default_collection/dataStores/${dataStoreId}/servingConfigs/default_search`;

  try {
    const [answerResponse] = await client.answer({
      name: servingConfig,
      query: { text: patientMessage },
      session: `projects/${projectId}/locations/${location}/collections/default_collection/dataStores/${dataStoreId}/sessions/${patientId}`,
      answerGenerationSpec: {
        includeCitations: false,
        ignoreAdversarialQuery: true,
      },
    });

    const aiText = answerResponse?.answer?.answerText || 'No response from AI.';

    // Try to extract structured summary from the answer
    let summary = null;
    try {
      // Attempt to parse JSON from answer text if it contains structured data
      const jsonMatch = aiText.match(/\{[\s\S]*"possibleCondition"[\s\S]*\}/);
      if (jsonMatch) {
        summary = JSON.parse(jsonMatch[0]);
      } else {
        summary = {
          possibleCondition: aiText.split('.')[0] || '',
          urgency: 'low',
          recommendation: aiText,
        };
      }
    } catch (_) {
      summary = {
        possibleCondition: aiText.substring(0, 100),
        urgency: 'low',
        recommendation: aiText,
      };
    }

    return { answer: aiText, summary };

  } catch (error) {
    console.error('Vertex AI error:', error);
    return {
      answer: 'Kechirasiz, hozircha AI javob bera olmadi. Iltimos keyinroq urinib ko\'ring.',
      summary: { possibleCondition: '', urgency: 'low', recommendation: 'AI unavailable' },
    };
  }
});

// ─────────────────────────────────────────────────────────
// onDiagnosisCreated — Firestore trigger
// ─────────────────────────────────────────────────────────
exports.onDiagnosisCreated = functions.firestore
  .document('users/{patientId}/diagnoses/{diagnosisId}')
  .onCreate(async (snap, context) => {
    const { patientId, diagnosisId } = context.params;
    const diagnosis = snap.data();

    // Get patient info
    const patientDoc = await db.collection('users').doc(patientId).get();
    const patientData = patientDoc.data() || {};
    const linkedDoctorId = patientData.linkedDoctorId;
    const patientName = patientData.displayName || patientData.email || 'Noma\'lum';

    if (!linkedDoctorId) {
      console.log(`No linkedDoctorId for patient ${patientId}, skipping notification`);
      return;
    }

    // Create notification for doctor
    await db.collection('users').doc(linkedDoctorId).collection('notifications').add({
      patientId: patientId,
      patientName: patientName,
      diagnosisId: diagnosisId,
      possibleCondition: diagnosis.possibleCondition || '',
      urgency: diagnosis.urgency || 'low',
      chatId: diagnosis.chatId || '',
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
      isRead: false,
    });

    // Send FCM push
    const doctorDoc = await db.collection('users').doc(linkedDoctorId).get();
    const doctorData = doctorDoc.data() || {};
    const fcmToken = doctorData.fcmToken;

    if (fcmToken) {
      try {
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title: 'Yangi AI tashxisi',
            body: `${patientName}: ${diagnosis.possibleCondition || 'Yangi tashxis'}`,
          },
          data: {
            patientId: patientId,
            type: 'new_diagnosis',
          },
        });
      } catch (e) {
        console.error('FCM send error:', e);
      }
    }
  });
