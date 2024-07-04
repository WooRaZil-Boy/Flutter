import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class APIRecipeQuery {
  factory APIRecipeQuery.fromJson(Map<String, dynamic> json) =>
      _$APIRecipeQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APIRecipeQueryToJson(this);
  // @JsonKey 어노테이션은 query 필드를 문자열 q로 JSON으로 표현한다고 명시합니다.
  // 나머지 필드는 여기에 있는 이름과 마찬가지로 JSON으로 표시됩니다.
  @JsonKey(name: 'q')
  String query;
  int from;
  int to;
  bool more;
  int count;
  List<APIHits> hits;

  // required 주석은 새 인스턴스를 만들 때 이러한 필드가 필수라고 알려줍니다.
  APIRecipeQuery({
    required this.query,
    required this.from,
    required this.to,
    required this.more,
    required this.count,
    required this.hits,
  });
}

// 클래스를 직렬화 가능으로 표시합니다.
@JsonSerializable()
class APIHits {
  APIRecipe recipe;

  // recipe 매개변수를 받는 생성자를 정의합니다.
  APIHits({
    required this.recipe,
  });

  // JSON 직렬화를 위한 메서드를 추가합니다.
  factory APIHits.fromJson(Map<String, dynamic> json) =>
      _$APIHitsFromJson(json);
  Map<String, dynamic> toJson() => _$APIHitsToJson(this);
}

@JsonSerializable()
class APIRecipe {
  String label;
  String image;
  String url;
  List<APIIngredients> ingredients;
  double calories;
  double totalWeight;
  double totalTime;

  APIRecipe({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
  });

  // JSON을 직렬화하기 위한 팩토리 메서드를 생성합니다.
  factory APIRecipe.fromJson(Map<String, dynamic> json) =>
      _$APIRecipeFromJson(json);
  Map<String, dynamic> toJson() => _$APIRecipeToJson(this);
}

String getCalories(double? calories) {
  if (calories == null) {
    return '0 KCAL';
  }
  return '${calories.floor()} KCAL';
}

String getWeight(double? weight) {
  if (weight == null) {
    return '0g';
  }
  return '${weight.floor()}g';
}

@JsonSerializable()
class APIIngredients {
  // name 필드가 text라는 JSON 필드에 매핑된다고 명시합니다.
  @JsonKey(name: 'text')
  String name;
  double weight;

  APIIngredients({
    required this.name,
    required this.weight,
  });

  // JSON을 직렬화하는 메서드를 만듭니다.
  factory APIIngredients.fromJson(Map<String, dynamic> json) =>
      _$APIIngredientsFromJson(json);
  Map<String, dynamic> toJson() => _$APIIngredientsToJson(this);
}

// 터미널에서 flutter pub run build_runner build를 입력하면
// 해당 폴더에 recipe_model.g.dart를 생성합니다.
// 파일을 변경할 때마다 프로그램이 실행되도록 하려면 다음과 같이 watch 명령을 사용할 수 있습니다:
// flutter pub run build_runner watch