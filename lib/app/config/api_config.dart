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

  Map<String, String> onSetBasicHeaderData() {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    return header;
  }

  Map<String, String> onSetTokenHeaderData({required String token}) {
    Map<String, String> headerToken = {
      "Content-Type": "application/json",
      "x-access-token": token
    };
    return headerToken;
  }

  Future<String> onSendOrGetSource(
      {required String url,
        required String methodType,
        Map<String, String>? header,
        Map? body}) async {
    http.Response response = methodType == 'GET'
        ? await http.get(Uri.parse(url), headers: header)
        : await http.post(Uri.parse(url),
        headers: header, body: jsonEncode(body));

    String rescode = response.statusCode.toString();
    String tempresult = '';
    String result = 'Error';

    if (response.statusCode == 200 &&
        !response.body.toUpperCase().contains('INVALID TOKEN') &&
        !response.body.toUpperCase().contains('UNAUTORIZED') &&
        !response.body.toUpperCase().contains('SERVER UNAVAILABLE')) {
      result = response.body;
    } else if (response.statusCode == 400) {
      tempresult = 'Error ' + rescode + ', Bad Request';
    } else if (response.statusCode == 401) {
      tempresult = 'Error ' + rescode + ', Unautorized';
    } else if (response.statusCode == 404) {
      tempresult = 'Error ' + rescode + ', Not Found';
    } else if (response.statusCode == 500) {
      tempresult = 'Error ' + rescode + ', Internal Server Error';
    } else if (response.statusCode == 502) {
      tempresult = 'Error ' + rescode + ', Bad Gateway';
    } else if (response.statusCode == 503) {
      tempresult = 'Error ' + rescode + ', Service Unavailable';
    } else if (response.body.contains('INVALID TOKEN')) {
      tempresult = 'Error ' + rescode;
    } else {
      tempresult = 'Error' + rescode;
    }

    result = tempresult.toLowerCase().contains('error')
        ? tempresult + " " + response.body
        : response.body;

    return result;
  }

}