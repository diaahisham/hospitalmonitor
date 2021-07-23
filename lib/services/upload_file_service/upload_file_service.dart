import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as common;

class FileUploadService {
  Future<String> uploadFile(String fileString, List<int> bytes) async {
    String url = common.baseURL + '/api/upload-file';
    String result = '';

    final MultipartFile file =
        MultipartFile.fromBytes("file", bytes, filename: fileString);

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..files.add(file);

    var response = await request.send();
    //print(response.statusCode);

    result = await response.stream.bytesToString();
    return result;
  }
}
