import 'models/models.dart';

// Dart에는 키워드 인터페이스가 없고 대신 abstract class를 사용한다는 점을 기억하세요.
// 즉, 모든 리포지토리가 구현할 메서드를 추가해야 합니다.
abstract class Repository {
  // 리포지토리에 있는 모든 Recipe를 반환합니다.
  List<Recipe> findAllRecipes();
  // ID로 특정 Recipe를 찾습니다.
  Recipe findRecipeById(int id);
  // 모든 Ingredient를 반환합니다.
  List<Ingredient> findAllIngredients();
  // 주어진 레시피 ID에 해당하는 모든 Ingredient를 찾습니다.
  List<Ingredient> findRecipeIngredients(int recipeId);

  // 새 Recipe를 삽입합니다.
  int insertRecipe(Recipe recipe);
  // 주어진 Ingredient를 모두 추가합니다.
  List<int> insertIngredients(List<Ingredient> ingredients);

  // 주어진 Recipe를 삭제합니다.
  void deleteRecipe(Recipe recipe);

  // 주어진 Ingredient를 삭제합니다.
  void deleteIngredient(Ingredient ingredient);

  // 지정된 모든 Ingredient를 삭제합니다.
  void deleteIngredients(List<Ingredient> ingredients);

  // 지정된 Recipe ID의 모든 Ingredient를 삭제합니다.
  void deleteRecipeIngredients(int recipeId);

  // 리포지토리가 초기화되도록 허용합니다. 데이터베이스가 시작 작업을 수행해야 할 수 있습니다.
  Future init();
  // 리포지토리를 닫습니다.
  void close();
}