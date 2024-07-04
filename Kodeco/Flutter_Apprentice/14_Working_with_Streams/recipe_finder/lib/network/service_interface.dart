import 'package:chopper/chopper.dart';
import 'model_response.dart';
import 'recipe_model.dart';

abstract class ServiceInterface {
  // 이 클래스의 매개변수와 반환값은 RecipeService 및 MockService와 동일합니다.
  // 각 서비스가 이 인터페이스를 구현하도록 하면 특정 클래스 대신 이 인터페이스를 제공하도록 공급자를 변경할 수 있습니다.
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
    String query,
    int from,
    int to,
  );
}