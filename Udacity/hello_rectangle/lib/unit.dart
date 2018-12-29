import 'package:meta/meta.dart';

class Unit {
  final String name;
  final double conversion;

  const Unit({
    @required this.name,
    @required this.conversion
  })  : assert(name != null),
        assert(conversion != null);

  Unit.fromJson(Map jsonMap) //JSON에서 Unit을 생성한다.
      : assert(jsonMap['name'] != null),
        assert(jsonMap['conversion'] != null),
        name = jsonMap['name'],
        conversion = jsonMap['conversion'].toDouble();
}