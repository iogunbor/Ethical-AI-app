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
