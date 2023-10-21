import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class APIConfig {
  Future<String> sendDataToApi({required String url, required method, List? body}) async {
    String result = 'error';
    var apiUrl = Uri.parse(url);
    // Data yang akan dikirim dalam bentuk JSON
    var headers = {'Content-Type': 'application/json'};

    var response = method == 'POST' ? await http.post(
      apiUrl,
      headers: headers,
      body: json.encode(body),
    ) : await http.get(
      apiUrl,
      headers: headers,
    );
    log('response '+response.body);

    if (response.statusCode == 200) {
      result = response.body;
    } else {
      print('Gagal mengirim data. Kode status: ${response.statusCode}');
    }

    return result;
  }

}