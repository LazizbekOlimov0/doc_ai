import 'package:firebase_auth/firebase_auth.dart';

String mapFirebaseAuthError(String code) {
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
      return 'Bu amalga ruxsat berilmagan';
    case 'too-many-requests':
      return 'Juda ko\'p urinish, keyinroq qayta urinib ko\'ring';
    case 'network-request-failed':
      return 'Internet aloqasi yo\'q, tarmoqni tekshiring';
    case 'channel-error':
      return 'Firebase ulanmagan. Iltimos ilovani qayta yuklang.';
    case 'requires-recent-login':
      return 'Iltimos qaytadan tizimga kiring';
    case 'account-exists-with-different-credential':
      return 'Bu email boshqa usul bilan ro\'yxatdan o\'tgan';
    case 'provider-already-linked':
      return 'Bu akkaunt allaqachon bog\'langan';
    case 'credential-already-in-use':
      return 'Bu hisob ma\'lumotlari allaqachon ishlatilgan';
    default:
      return 'Xatolik yuz berdi. Qayta urinib ko\'ring. ($code)';
  }
}

String mapFirebaseError(dynamic error) {
  if (error is FirebaseAuthException) {
    return mapFirebaseAuthError(error.code);
  }
  if (error is FirebaseException) {
    return mapFirebaseAuthError(error.code);
  }
  if (error is Exception) {
    final message = error.toString();
    final match = RegExp(r'\[(.*?)\]').firstMatch(message);
    final code = match?.group(1) ?? '';
    if (code.isNotEmpty) {
      return mapFirebaseAuthError(code);
    }
  }
  return 'Noma\'lum xatolik yuz berdi';
}
