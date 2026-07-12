String mapFirebaseAuthError(String code) {
  switch (code) {
    case 'invalid-email':
    case 'invalid-credential':
      return 'auth_error.invalid_email';
    case 'user-disabled':
      return 'auth_error.user_disabled';
    case 'user-not-found':
      return 'auth_error.user_not_found';
    case 'wrong-password':
      return 'auth_error.wrong_password';
    case 'email-already-in-use':
      return 'auth_error.email_already_in_use';
    case 'weak-password':
      return 'auth_error.weak_password';
    case 'operation-not-allowed':
      return 'auth_error.operation_not_allowed';
    case 'too-many-requests':
      return 'auth_error.too_many_requests';
    case 'network-request-failed':
      return 'auth_error.network_error';
    default:
      return 'auth_error.unknown_error';
  }
}

String mapFirebaseError(dynamic error) {
  if (error is Exception) {
    final code =
        error.toString().contains('[') ? _extractCode(error.toString()) : '';
    return mapFirebaseAuthError(code);
  }
  return 'auth_error.unknown_error';
}

String _extractCode(String message) {
  final match = RegExp(r'\[(.*?)\]').firstMatch(message);
  return match?.group(1) ?? '';
}
