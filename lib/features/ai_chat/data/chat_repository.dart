import 'package:cloud_functions/cloud_functions.dart';

abstract class ChatRepository {
  Future<String> askDocAiAgent({required String patientMessage});
}

class FirebaseChatRepository implements ChatRepository {
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(region: 'us-central1');

  @override
  Future<String> askDocAiAgent({required String patientMessage}) async {
    try {
      final callable = _functions.httpsCallable('askDocAiAgent');
      final result = await callable.call(<String, dynamic>{
        'patientMessage': patientMessage,
      });
      final data = result.data as Map<String, dynamic>;
      return data['answer'] as String? ?? await _mock(patientMessage);
    } catch (_) {
      return await _mock(patientMessage);
    }
  }

  Future<String> _mock(String msg) async {
    // Simulate AI thinking time
    await Future<void>.delayed(const Duration(seconds: 1));
    return _fallback(msg);
  }

  String _fallback(String msg) {
    final lowered = msg.toLowerCase();

    if (lowered.contains('bosh') || lowered.contains('golova')) {
      return 'Bosh og\'rig\'i ko\'p sabablarga ko\'ra yuzaga kelishi mumkin: stress, ko\'z charchashi, suvsizlanish, yuqori qon bosimi yoki migren.\n\n'
          'Tavsiyalar:\n'
          '• Ko\'proq suv iching (kuniga 8-10 stakan)\n'
          '• 15-20 daqiqa dam oling, ko\'zingizni yuming\n'
          '• Agar qon bosimingiz yuqori bo\'lsa, shifokorga murojaat qiling\n'
          '• Doimiy og\'riq bo\'lsa, nevropatolog konsultatsiyasi tavsiya etiladi';
    }
    if (lowered.contains('qon') || lowered.contains('bosim') || lowered.contains('gipertoniya')) {
      return 'Qon bosimi haqida:\n\n'
          'Normal qon bosimi: 120/80 mmHg\n'
          'Yuqori qon bosimi (gipertoniya): 140/90 dan yuqori\n\n'
          'Tavsiyalar:\n'
          '• Tuz iste\'molini kamaytiring\n'
          '• Muntazam jismoniy mashq qiling\n'
          '• Stressni kamaytiring\n'
          '• Shifokor tayinlagan dorilarni muntazam qabul qiling\n'
          '• Qon bosimini har kuni o\'lchab boring';
    }
    if (lowered.contains('qand') || lowered.contains('diabet') || lowered.contains('shakar')) {
      return 'Qandli diabet haqida:\n\n'
          'Asosiy belgilar: ko\'p siyish, chanqoqlik, vazn yo\'qotish, charchoqlik.\n\n'
          'Tavsiyalar:\n'
          '• Qonda shakar miqdorini muntazam tekshirib boring\n'
          '• Sog\'lom ovqatlanish — kam uglevodli mahsulotlar\n'
          '• Jismoniy faollikni oshiring\n'
          '• Endokrinolog nazoratida bo\'ling\n'
          '• Oyoqlaringizni har kuni tekshirib boring (diabetik tovon xavfi)';
    }
    if (lowered.contains('yurak') || lowered.contains('ko\'krak') || lowered.contains('yurek')) {
      return 'Yurak bilan bog\'liq simptomlar jiddiy bo\'lishi mumkin.\n\n'
          'Agar ko\'krak qafasida og\'riq, nafas qisishi, chap qo\'l yoki jag\'da og\'riq bo\'lsa — tez tibbiy yordam chaqiring (103)!\n\n'
          'Tavsiyalar:\n'
          '• Darhol EKG tekshiruvidan o\'ting\n'
          '• Kardiolog konsultatsiyasi\n'
          '• Yog\'li va qovurilgan ovqatlardan voz keching\n'
          '• Yurish va yengil jismoniy mashqlar foydali';
    }
    if (lowered.contains('harorat') || lowered.contains('isitma') || lowered.contains('temperatura')) {
      return 'Tana harorati ko\'tarilishi — organizmning infeksiyaga qarshi himoya reaksiyasi.\n\n'
          'Tavsiyalar:\n'
          '• 38.5°C gacha haroratni tushirish shart emas\n'
          '• Ko\'p suyuqlik iching (suv, choy, kompot)\n'
          '• Yengil kiyining, xona haroratini 20-22°C da saqlang\n'
          '• Paratsetamol yoki ibuprofen (dozasiga rioya qiling)\n'
          '• Agar 3 kundan ortiq davom etsa yoki 39°C dan oshsa — shifokorga murojaat qiling';
    }
    if (lowered.contains('yo\'tal')) {
      return 'Yo\'tal — nafas yo\'llari kasalliklarining eng ko\'p uchraydigan belgisi.\n\n'
          'Tavsiyalar:\n'
          '• Ko\'p iliq suyuqlik iching\n'
          '• Asal va limon choyi foydali\n'
          '• Nam havoda nafas oling\n'
          '• Agar quruq yo\'tal bo\'lsa — shifokor ko\'rigi kerak\n'
          '• Balg\'amli yo\'tal 2 haftadan ortiq davom etsa — pulmonologga murojaat qiling';
    }

    return 'Sizning simptomlaringiz asosida aniq tashxis qo\'yish qiyin. Quyidagi umumiy tavsiyalarni ko\'rib chiqing:\n\n'
        '• Ko\'proq suv iching va sog\'lom ovqatlaning\n'
        '• 7-8 soat uxlang\n'
        '• Stressni kamaytirishga harakat qiling\n'
        '• Agar simptomlar 2-3 kundan ortiq davom etsa, albatta shifokorga murojaat qiling\n\n'
        '📌 Bu AI maslahati — yakuniy tashxis emas. Jiddiy simptomlar bo\'lsa, darhol tibbiy yordamga murojaat qiling.';
  }
}
