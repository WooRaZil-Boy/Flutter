import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

enum Filter {
  all,
  active,
  completed,
}

class Todo extends Equatable {
  final String id;
  final String desc;
  final bool completed;

  // 새 객체를 생성/기존 객체를 수정 할 수 있기 때문에 id가 nullable이다.
  // 또한 편의를 위해 completed를 false로 기본값 설정한다.
  Todo({
    String? id,
    required this.desc,
    this.completed = false
  }) : this.id = id ?? uuid.v4();

  @override
  List<Object> get props => [id, desc, completed];

  @override
  String toString() => 'Todo(id: $id, desc: $desc, completed: $completed)';
}
