import 'dart:core';
import 'package:flutter/foundation.dart';
import 'repository.dart';
import 'models/models.dart';

// MemoryRepository는 Repository를 확장하고
// Flutter의 ChangeNotifier를 사용하여 리스너를 활성화하고 변경 사항을 리스너에 알립니다.
class MemoryRepository extends Repository with ChangeNotifier {
  // 현재 Recipe 목록을 초기화합니다.
  final List<Recipe> _currentRecipes = <Recipe>[];
  // 현재 Ingredient 목록을 초기화합니다.
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  @override
  List<Recipe> findAllRecipes() {
    // 현재 RecipeList을 반환합니다.
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    // 주어진 ID를 가진 Recipe를 찾기 위해 firstWhere를 사용합니다.
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    // 현재 Ingredient 목록을 반환합니다.
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    // 주어진 ID를 가진 Recipe를 찾습니다.
    final recipe =
      _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    // 주어진 Recipe ID를 가진 모든 재료를 찾을 where를 사용합니다.
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

  @override
  int insertRecipe(Recipe recipe) {
    // 목록에 Recipe를 추가합니다.
    _currentRecipes.add(recipe);
    // Recipe의 모든 Ingredient를 추가합니다.
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    // 모든 리스너에게 변경 사항을 알립니다.
    notifyListeners();
    // 새 Recipe의 ID를 반환합니다. 필요하지 않으므로 항상 0을 반환합니다.
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    // 일부 Ingredient가 있는지 확인합니다.
    if (ingredients.isNotEmpty) {
      // 모든 Ingredient를 목록에 추가합니다.
      _currentIngredients.addAll(ingredients);
      // 모든 리스너에게 변경 사항을 알립니다.
      notifyListeners();
    }
    // 추가된 ID 목록을 반환합니다. 지금은 빈 목록입니다.
    return <int>[];
  }

  @override
  void deleteRecipe(Recipe recipe) {
    // 목록에서 Recipe를 삭제합니다.
    _currentRecipes.remove(recipe);
    // 이 Recipe의 모든 Ingredient를 삭제합니다.
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    // 모든 리스너에게 데이터가 변경되었음을 알립니다.
    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    // 목록에서 Ingredient를 제거합니다.
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    // 전달된 목록에 있는 모든 Ingredient를 제거합니다.
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    // 모든 Ingredient를 살펴보고 지정된 Recipe ID를 가진 Ingredient를 찾은 다음 제거합니다.
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }

  // 메모리 저장소이므로 초기화 및 닫기를 위해 아무것도 할 필요가 없지만 이러한 메서드를 구현해야 합니다.
  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}