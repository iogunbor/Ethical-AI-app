import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = "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"; // Replace with your actual API key

  Future<String> fetchResponse(String prompt) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final headers = {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful assistant."
        },
        {
          "role": "user",
          "content": prompt
        }
      ]
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"].toString().trim();
      } else {
        throw Exception("OpenAI error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Connection failed: $e");
    }
  }
}
