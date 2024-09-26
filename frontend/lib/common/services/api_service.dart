import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://10.0.2.2:3000/examples';

  Future<List<dynamic>> fetchExamples() async {
    print('Fetching examples from $apiUrl'); // Log the API URL
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print('Fetched examples: ${response.body}'); // Log the fetched data
      return json.decode(response.body);
    } else {
      print(
          'Failed to load examples: ${response.statusCode}'); // Log the error status code
      throw Exception('Failed to load examples');
    }
  }
}
