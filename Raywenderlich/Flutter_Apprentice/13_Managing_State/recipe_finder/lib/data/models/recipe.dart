import 'package:equatable/equatable.dart';
import 'ingredient.dart';

class Recipe extends Equatable {
  // id는 final이 아니므로 업데이트할 수 있습니다.
  int? id;
  final String? label;
  final String? image;
  final String? url;

  List<Ingredient>? ingredients;
  final double? calories;
  final double? totalWeight;
  final double? totalTime;

  Recipe({
    this.id,
    this.label,
    this.image,
    this.url,
    this.calories,
    this.totalWeight,
    this.totalTime,
  });

  // 비교에 사용할 Equatable 속성을 위해 구현해 주어야 합니다.
  @override
  List<Object?> get props => [
    label,
    image,
    url,
    calories,
    totalWeight,
    totalTime
  ];
}