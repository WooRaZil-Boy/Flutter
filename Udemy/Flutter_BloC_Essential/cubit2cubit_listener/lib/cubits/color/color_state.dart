part of 'color_cubit.dart';

class ColorState extends Equatable {
  final Color color;
  
  ColorState({
    required this.color,
  });

  factory ColorState.inital() {
    return ColorState(color: Colors.red);
  }

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'ColorState(color: $color)';

  ColorState copyWith({
    Color? color,
  }) {
    return ColorState(
      color: color ?? this.color,
    );
  }
}
