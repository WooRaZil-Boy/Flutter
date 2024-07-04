import 'dart:core';
import 'repository.dart';
import 'models/models.dart';
import 'dart:async';

class MemoryRepository extends Repository {
  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  // 스트림이 처음 요청될 때 캡처되어 각 호출에 대해 새 스트림이 생성되지 않도록 합니다.
  Stream<List<Recipe>>? _recipeStream;
  Stream<List<Ingredient>>? _ingredientStream;

  final StreamController _recipeStreamController =
  StreamController<List<Recipe>>();
  final StreamController _ingredientStreamController =
  StreamController<List<Ingredient>>();

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    // 스트림이 이미 있는지 확인합니다. 그렇지 않은 경우 스트림 메서드를 호출하여 새 스트림을 생성한 다음 반환합니다.
    _recipeStream ??= _recipeStreamController.stream as Stream<List<Recipe>>;
    return _recipeStream!;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    // 스트림이 이미 있는지 확인합니다. 그렇지 않은 경우 스트림 메서드를 호출하여 새 스트림을 생성한 다음 반환합니다.
    _ingredientStream ??=
    _ingredientStreamController.stream as Stream<List<Ingredient>>;
    return _ingredientStream!;
  }

  @override
  // Future를 반환하도록 메서드를 변경합니다.
  Future<List<Recipe>> findAllRecipes() {
    // 반환값을 Future.value()로 래핑합니다.
    return Future.value(_currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(
        _currentRecipes.firstWhere((recipe) => recipe.id == id));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    final recipe =
    _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }

  @override
  // 메서드의 반환 유형을 Future로 업데이트합니다.
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    // StreamController의 sink 속성은 스트림에 데이터를 추가합니다.
    // 레시피 sink에 _currentRecipes를 추가합니다.
    // 이전 목록을 업데이트된 목록으로 대체합니다.
    _recipeStreamController.sink.add(_currentRecipes);

    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }

    // Future 값을 반환합니다.
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
      _ingredientStreamController.sink.add(_currentIngredients);
    }
    return Future.value(<int>[]);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }
}
