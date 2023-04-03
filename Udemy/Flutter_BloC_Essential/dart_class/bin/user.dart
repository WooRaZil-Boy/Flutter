// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
class User extends Equatable {
  // Equatable을 구현한 객체는 immutable 해야 하기 때문에 모든 멤버가 final이어야 한다.
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });


  @override
  // Equatable은 props list의 멤버들이 같으면 같은 클래스라고 판단한다.
  // 이를 수동으로 직접하려면 굉장히 번거롭다.
  List<Object> get props => [id, name, email];

  @override
  // print로 해당 객체를 호출했을 때 props에 나열된 멤버들을 함께 표시할지 여부를 설정한다.
  // 해당 설정이 없다면 'User' 있다면 'User(1, name, email)' 이런 식으로 출력된다.
  bool get stringify => true;
}
