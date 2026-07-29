import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const _apiKey = 'AIzaSyBRp25fqnfx6cq8Y-wCWWiA4q5P98cwlgw';
const _projectId = 'doc-ai-antigravity';
const _location = 'us';
const _dataStoreId = 'doc-ai-clinical-data_1785072129919';

String get _basePath => 'projects/$_projectId/locations/$_location/collections/default_collection/dataStores/$_dataStoreId/servingConfigs/default_search';
String _sessionPath(String patientId) => 'projects/$_projectId/locations/$_location/collections/default_collection/dataStores/$_dataStoreId/sessions/$patientId';

abstract class ChatRepository {
  Future<String> askDocAiAgent({
    required String patientMessage,
    required String patientId,
  });
}

class FirebaseChatRepository implements ChatRepository {
  @override
  Future<String> askDocAiAgent({
    required String patientMessage,
    required String patientId,
  }) async {
    // Strategy 1: API key in header (x-goog-api-key)
    final result1 = await _tryAnswer(
      patientMessage: patientMessage,
      patientId: patientId,
      strategy: 'header',
    );
    if (result1 != null) return result1;

    // Strategy 2: API key in query param (?key=)
    final result2 = await _tryAnswer(
      patientMessage: patientMessage,
      patientId: patientId,
      strategy: 'query',
    );
    if (result2 != null) return result2;

    // Strategy 3: API key in both header and query
    final result3 = await _tryAnswer(
      patientMessage: patientMessage,
      patientId: patientId,
      strategy: 'both',
    );
    if (result3 != null) return result3;

    throw Exception(
      'Discovery Engine API javob bermadi.\n\n'
      'Sabab: :answer metodi API key auth ni qo\'llab-quvvatlamaydi (faqat service account kerak).\n\n'
      'Yechim: Cloud Functions orqali deploy qilish kerak (Blaze plan: ~\$0.01/oy).\n'
      'Yoki: firebase_ai Vertex AI ni yoqib ishlatish.\n\n'
      'Log\'lar: yuqorida 🔴 xatolik sabablari ko\'rsatilgan.',
    );
  }

  Future<String?> _tryAnswer({
    required String patientMessage,
    required String patientId,
    required String strategy,
  }) async {
    try {
      final uriStr = strategy == 'header'
          ? 'https://discoveryengine.googleapis.com/v1beta/$_basePath:answer'
          : 'https://discoveryengine.googleapis.com/v1beta/$_basePath:answer?key=$_apiKey';

      final uri = Uri.parse(uriStr);
      final body = jsonEncode({
        'query': {'text': patientMessage},
        'session': _sessionPath(patientId),
        'answerGenerationSpec': {
          'includeCitations': false,
          'ignoreAdversarialQuery': true,
        },
      });

      final headers = <String, String>{'Content-Type': 'application/json'};
      if (strategy == 'header' || strategy == 'both') {
        headers['x-goog-api-key'] = _apiKey;
      }

      debugPrint('🔵 ChatRepo [$strategy]: calling discoveryengine:answer...');
      final response = await http.post(uri, headers: headers, body: body);

      debugPrint('🔵 ChatRepo [$strategy]: status=${response.statusCode}, bodyLen=${response.body.length}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final answer = data['answer'] as Map<String, dynamic>?;
        final answerText = answer?['answerText'] as String?;
        if (answerText != null && answerText.trim().isNotEmpty) {
          debugPrint('🟢 ChatRepo [$strategy]: SUCCESS (${answerText.length} chars)');
          return answerText;
        }
      }

      final errorSnippet = response.body.length > 200
          ? response.body.substring(0, 200)
          : response.body;
      debugPrint('🔴 ChatRepo [$strategy]: FAILED status=${response.statusCode} body=$errorSnippet');
      return null;
    } catch (e) {
      debugPrint('🔴 ChatRepo [$strategy]: EXCEPTION $e');
      return null;
    }
  }
}
