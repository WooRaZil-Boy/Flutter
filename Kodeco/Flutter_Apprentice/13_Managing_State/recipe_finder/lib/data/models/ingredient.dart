import 'package:equatable/equatable.dart';

// Ingredient 클래스는 Equatable을 확장하여 동일성 검사를 지원합니다.
class Ingredient extends Equatable {
  // 나중에 해당 값을 변경할 수 있도록 recipeId 또는 id를 final으로 선언하지 않습니다.
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  Ingredient({
    this.id,
    this.recipeId,
    this.name,
    this.weight,
  });

  // 동일성 검사가 수행될 때 Equatable은 props 값을 사용합니다. 여기에서 동일성 검사에 사용할 필드를 제공합니다.
  @override
  List<Object?> get props => [
    recipeId,
    name,
    weight,
  ];
}