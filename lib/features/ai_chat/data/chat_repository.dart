import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class ChatRepository {
  Future<String> askDocAiAgent({
    required String patientMessage,
    required String patientId,
  });
}

class FirebaseChatRepository implements ChatRepository {
  final String _apiUrl;
  final String _apiKey;

  FirebaseChatRepository({
    String? apiUrl,
    String? apiKey,
  })  : _apiUrl = apiUrl ?? dotenv.env['DOC_AI_API_URL'] ?? '',
        _apiKey = apiKey ?? dotenv.env['DOC_AI_API_KEY'] ?? '';

  @override
  Future<String> askDocAiAgent({
    required String patientMessage,
    required String patientId,
  }) async {
    if (_apiUrl.isEmpty || _apiKey.isEmpty) {
      throw Exception('API konfiguratsiyasi topilmadi. .env faylni tekshiring.');
    }

    debugPrint('🔵 ChatRepo: calling $_apiUrl/ask');

    try {
      final uri = Uri.parse('$_apiUrl/ask');
      final body = jsonEncode({'message': patientMessage});

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': _apiKey,
        },
        body: body,
      );

      debugPrint('🔵 ChatRepo: status=${response.statusCode}, bodyLen=${response.body.length}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final answer = data['answer'] as String?;
        if (answer != null && answer.trim().isNotEmpty) {
          debugPrint('🟢 ChatRepo: AI response (${answer.length} chars)');
          return answer;
        }
        throw Exception('AI bo\'sh javob qaytardi.');
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception('API autentifikatsiyasi muvaffaqiyatsiz. API kalitni tekshiring.');
      }

      throw Exception('Server xatosi (${response.statusCode}). Qayta urinib ko\'ring.');
    } catch (e) {
      debugPrint('🔴 ChatRepo ERROR: $e');
      rethrow;
    }
  }
}
