import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/attachment_file_data_model.dart';

class APIConfig {
  Future<String> sendDataToApi(
      {required String url, required method, List? body, String? type}) async {
    String result = 'error';
    var apiUrl = Uri.parse(url);

    // Data yang akan dikirim dalam bentuk JSON
    var headers = {'Content-Type': 'application/json'};

    var response = method == 'POST' ? await http.post(
      apiUrl,
      headers: type == 'wallet' ? onSetBasicHeaderData() : headers,
      body: json.encode(body),
    ) : await http.get(
      apiUrl,
      headers: type == 'wallet' ? onSetBasicHeaderData() : headers,
    );
    log('response ' + response.body);

    if (response.statusCode == 200) {
      result = response.body;
    } else {
      print('Gagal mengirim data. Kode status: ${response.statusCode}');
    }

    return result;
  }

  Map<String, String> onSetBasicHeaderData() {
    Map<String, String> header = {
      "Authorization": "basic f6nujgledfyzawk21e24",
      "Content-Type": "application/json",
      "X-AppId": "MYR-001",
      "X-AppKey": "01e1dd37-3121-43b8-9633-97b4f2eabe93",
    };

    return header;
  }

  Map<String, String> onSetHeaderWalletId({required String wallet_id}) {
    Map<String, String> header = {
      "Authorization": "basic f6nujgledfyzawk21e24",
      "Content-Type": "application/json",
      "X-AppId": "MYR-001",
      "X-AppKey": "01e1dd37-3121-43b8-9633-97b4f2eabe93",
      "X-WalletId": wallet_id
    };

    return header;
  }

  Map<String, String> onSetHeaderData({required String token}) {
    Map<String, String> headerData = {
      "Content-Type": "application/json",
      "x-access-token": token
    };
    return headerData;
  }

  Future<String> onSendOrGetSource({required String url,
    required String methodType,
    String? headerType,
    Map<String, String>? header,
    String? wallet_id,
    Map? body}) async {
    http.Response response = methodType == 'GET'
        ? await http.get(Uri.parse(url),
      headers: headerType == 'wallet' ? onSetBasicHeaderData() : headerType ==
          'setWallet' ? onSetHeaderWalletId(wallet_id: wallet_id!) : header)
        : await http.post(Uri.parse(url),
        headers: headerType == 'wallet' ? onSetBasicHeaderData() : headerType ==
            'setWallet' ? onSetHeaderWalletId(wallet_id: wallet_id!) : header,
        body: jsonEncode(body));

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

  Future<AttachmentFileDataModel> uploadAttachment(
      {required File filepath}) async {
    AttachmentFileDataModel dataUploadAttachment = AttachmentFileDataModel();
    String uploadResult = await uploadFile(
      uploadUrl: GlobalUrl.baseUrl + GlobalUrl.uploadAttachment,
      file: filepath,
    );
    dataUploadAttachment =
        AttachmentFileDataModel.fromJson(json.decode(uploadResult));
    return dataUploadAttachment;
  }

  Future<String> uploadFile(
      {required String uploadUrl, required File file}) async {
    String result = '';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
    var multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);
    var response = await request.send();
    result = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print('File uploaded');
    } else {
      print('Error uploading file: ${response.reasonPhrase}');
    }

    return result;
  }

  Future<Uint8List> getFile({required String uploadUrl}) async {
    Uint8List imageData;
    final http.Response response = await http.get(Uri.parse(uploadUrl));
    imageData = Uint8List.fromList(response.bodyBytes);

    return imageData;
  }

}