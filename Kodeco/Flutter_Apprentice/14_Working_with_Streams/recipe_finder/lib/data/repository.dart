
import 'models/models.dart';

abstract class Repository {
  Future<List<Recipe>> findAllRecipes();
  // watchAllRecipes()는 레시피 목록에 변경 사항이 있는지 감시합니다.
  Stream<List<Recipe>> watchAllRecipes();
  // watchAllIngredients()는 Groceries 화면에 표시되는 재료 목록의 변경 사항을 수신 대기합니다.
  Stream<List<Ingredient>> watchAllIngredients();

  Future<Recipe> findRecipeById(int id);

  Future<List<Ingredient>> findAllIngredients();

  Future<List<Ingredient>> findRecipeIngredients(int recipeId);

  Future<int> insertRecipe(Recipe recipe);

  Future<List<int>> insertIngredients(List<Ingredient> ingredients);

  Future<void> deleteRecipe(Recipe recipe);

  Future<void> deleteIngredient(Ingredient ingredient);

  Future<void> deleteIngredients(List<Ingredient> ingredients);

  Future<void> deleteRecipeIngredients(int recipeId);

  Future init();

  void close();
}