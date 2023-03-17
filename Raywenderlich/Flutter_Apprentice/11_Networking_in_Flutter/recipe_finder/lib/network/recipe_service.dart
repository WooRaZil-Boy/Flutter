import 'dart:developer';
import 'package:http/http.dart';

const String apiKey = '186f49da8995bf8f6822b358f3cd7e2f';
const String apiId = '0a718960';
const String apiUrl = 'https://api.edamam.com/search';

class RecipeService {
  // getData()는 API가 반환하는 데이터 유형이 미래에 결정되므로 Future를 반환합니다.
  // async는 이 메서드가 비동기 작업임을 나타냅니다.
  Future getData(String url) async {
    // response은 await이 완료될 때까지 값을 갖지 않습니다.
    // Response과 get()은 HTTP 패키지에서 가져온 것입니다. get()은 제공된 url에서 데이터를 가져옵니다.
    final response = await get(Uri.parse(url));
    // statusCode가 200이면 요청이 성공했음을 의미합니다.
    if (response.statusCode == 200) {
      // response.body에 포함된 결과를 return합니다.
      return response.body;
    } else {
      // 그렇지 않으면 오류가 발생한 것이므로 콘솔에 statusCode를 출력합니다.
      log(response.body);
    }
  }

  // 이 메서드에 Future<dynamic> 유형을 사용하는 이유는 어떤 데이터 유형이 반환될지 또는 언제 완료될지 모르기 때문입니다.
  // async는 이 메서드가 비동기적으로 실행됨을 나타냅니다.
  Future<dynamic> getRecipes(String query, int from, int to) async {
    // final을 사용하여 변경되지 않는 변수를 만듭니다.
    // await을 사용하면 getData()가 결과를 반환할 때까지 기다리라고 앱에 지시할 수 있습니다.
    final recipeData = await getData('$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');

    return recipeData;
  }
}