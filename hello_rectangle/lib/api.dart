import "dart:async";
import "dart:convert" show json, utf8;
import "dart:io"; //networking 위해 필요한 패키지

const apiCategory = { //Converter에서 Currency를 선택한 경우 API를 사용한다.
  "name": "Currency",
  "route": "currency",
};

class Api {
  final HttpClient _httpClient = HttpClient(); //HTTP 프로토콜 사용해 콘텐츠 수신하는 클라이언트
  final String _url = "flutter.udacity.com"; //HTTP endpoint //이 주소를 바꿔서 에러 테스트를 할 수 있다.

  Future<List> getUnits(String category) async { //비동기로 가져온다.
    final uri = Uri.https(_url, "/$category"); //GET 주소
    final jsonResponse = await _getJson(uri);

    if (jsonResponse == null || jsonResponse["units"] == null) { //오류
      print("Error retrieving units.");
      return null;
    }
    return jsonResponse["units"];
  }

  Future<double> convert(String category, String amount, String fromUnit, String toUnit) async { //비동기
    final uri = Uri.https(_url, "/$category/convert",
      {"amount": amount, "from": fromUnit, "to": toUnit}); //GET 주소
    final jsonResponse = await _getJson(uri);

    if (jsonResponse == null || jsonResponse["status"] == null) {
      print("Error retrieving conversion.");
      return null;
    } else if (jsonResponse["status"] == "error") {
      print(jsonResponse["message"]);
      return null;
    }

    return jsonResponse["conversion"].toDouble();
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async { //비동기
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      
      if (httpResponse.statusCode != HttpStatus.OK) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();

      return json.decode(responseBody);
    } on Exception catch (e) { //오류
      print('$e');
      return null;
    }
  }
}

//Flutter는 싱글 스레드이기 때문에, HTTP 등의 작업을 할 때, 반환값을 기다리면서 앱이 frozen 되게 된다.
//이 경우 Asynchronous Operation을 사용하면 유저 경험을 향상 시킬 수 있다.
//Dart는 async 연산을 나타내기 위해 Future를 사용한다.
//async와 await를 사용한다.


