import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:chopper/chopper.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../network/model_response.dart';
import '../network/recipe_model.dart';

class MockService {
  // _currentRecipes1과 _currentRecipes2를 사용하여 두 개의 JSON 파일에서 로드한 결과를 저장합니다.
  late APIRecipeQuery _currentRecipes1;
  late APIRecipeQuery _currentRecipes2;
  // nextRecipe는 0과 1 사이의 숫자를 생성하는 Random의 인스턴스입니다.
  Random nextRecipe = Random();

  // Provider가 호출할 create() 메서드는 loadRecipes()만 호출합니다.
  void create() {
    loadRecipes();
  }

  void loadRecipes() async {
    // rootBundle은 JSON 파일을 문자열로 로드합니다.
    var jsonString = await rootBundle.loadString('assets/recipes1.json');
    // jsonDecode()는 레시피 목록을 가져오는 데 사용할 APIRecipeQuery맵을 생성합니다.
    _currentRecipes1 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
    jsonString = await rootBundle.loadString('assets/recipes2.json');
    _currentRecipes2 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
  }

  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      String query,
      int from,
      int to,
    ) {
    // 임의 필드를 사용하여 0 또는 1 중 임의의 정수를 선택합니다.
    switch (nextRecipe.nextInt(2)) {
      case 0:
      // APIRecipeQuery 결과를 Success, Response 및 Future로 래핑합니다.
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<APIRecipeQuery>(_currentRecipes1),
          ),
        );
      case 1:
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<APIRecipeQuery>(_currentRecipes2),
          ),
        );
      default:
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<APIRecipeQuery>(_currentRecipes1),
          ),
        );
    }
  }
}