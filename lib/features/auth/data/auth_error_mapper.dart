import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

String _u(String code) {
  switch (code) {
    case 'invalid-email':
    case 'invalid-credential':
      return 'Noto\'g\'ri email manzil';
    case 'user-disabled':
      return 'Bu foydalanuvchi bloklangan';
    case 'user-not-found':
      return 'Bunday foydalanuvchi topilmadi';
    case 'wrong-password':
    case 'invalid-password':
      return 'Noto\'g\'ri parol';
    case 'email-already-in-use':
      return 'Bu email allaqachon band';
    case 'weak-password':
      return 'Parol juda oddiy, kamida 6 ta belgi';
    case 'operation-not-allowed':
      return 'Email/parol orqali kirish hali yoqilmagan. Firebase Console > Authentication > Sign-in method bo\'limidan Email/Password ni yoqing.';
    case 'too-many-requests':
      return 'Juda ko\'p urinish, keyinroq qayta urinib ko\'ring';
    case 'network-request-failed':
      return 'Internet aloqasi yo\'q, tarmoqni tekshiring';
    case 'channel-error':
      return 'Firebase ulanmagan. Iltimos ilovani qayta yuklang.';
    case 'internal-error':
      return 'Firebase serverida ichki xatolik. Email/Parol autentifikatsiyasi Firebase Console\'da yoqilganligini tekshiring.';
    default:
      return 'Xatolik yuz berdi. Qayta urinib ko\'ring.';
  }
}

String mapFirebaseError(dynamic error) {
  if (error is FirebaseAuthException) {
    debugPrint('FirebaseAuthException: code=${error.code}');
    return _u(error.code);
  }
  if (error is FirebaseException) {
    debugPrint('FirebaseException: code=${error.code}');
    return _u(error.code);
  }
  if (error is Exception) {
    final message = error.toString();
    debugPrint('Exception: $message');
    final match = RegExp(r'\[(.*?)\]').firstMatch(message);
    final code = match?.group(1) ?? '';
    if (code.isNotEmpty) return _u(code);
  }
  return 'Noma\'lum xatolik yuz berdi';
}
