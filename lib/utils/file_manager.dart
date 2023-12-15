import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class FileManager {
  static Future<File?> downloadImage(String url) async {
    // HTTP 요청을 사용하여 이미지 데이터를 가져옵니다.
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // 임시 디렉토리의 경로를 얻습니다.
      final directory = await getTemporaryDirectory();

      // 파일 경로를 정의합니다.
      final filePath = '${directory.path}/my_image.jpg';
      // 파일 객체를 생성합니다.
      final file = File(filePath);

      // 파일에 이미지 데이터를 씁니다.
      return await file.writeAsBytes(response.bodyBytes);
    } else {
      return null;
    }
  }

  static Future<void> deleteFile(File file) async {
    if(file.existsSync()) {
      await file.delete(); 
    }
  }
}
