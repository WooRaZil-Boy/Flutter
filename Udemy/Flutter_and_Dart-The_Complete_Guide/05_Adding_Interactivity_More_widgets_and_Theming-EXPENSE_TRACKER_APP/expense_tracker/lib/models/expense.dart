import 'package:uuid/uuid.dart';

// uuid 생성 자체는 Expense에 국한된 것이 아니기 때문에 Expense 외부에서 생성한다.
const uuid = Uuid();

// category를 String으로 선언하면, 임의의 문자열이 모두 유효하므로 오타가 발생해도 알아차리기 힘들다.
// 따라서 여기서는 enum을 사용한다. enum은 정해진 값만을 가질 수 있도록 제한한다.
// enum의 case는 문자열이 아니지만, Dart는 이 값들을 문자열로 변환할 수 있다.
enum Category { food, trvel, leisure, work}

// Data Model 클래스를 작성한다. 한 항목의 비용을 설명한다.
class Expense {
  // 수정/삭제를 위해서는 고유한 id도 가지고 있어야 한다.
  final String id;
  final String title;
  final double amount;
  // Dart 내장된 클래스로 날짜를 표현한다.
  final DateTime date;
  // 범주 별로 차트를 그린다. 
  final Category category;

  // 객체의 멤머가 많아질 수록, 생성자에서 인자를 빼먹거나 순서를 헤깔릴 수 있다.
  // 이런 경우에는 required로 인자를 명시해 주는 것이 좋다. 해당 인자가 자동완성되며 순서에 영향받지 않는다.
  // id는 새로운 Expense 객체가 생성될때마다 동적으로 고유 id를 생성하도록 한다.
  // 여기서는 uuid 패키지를 사용한다. 터미널에서 flutter pub add uuid를 사용하여 바로 추가할 수 있다.
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    // 세미콜론 이후 초기화 목록을 추가할 수 있다. 객체가 생성될 때 값을 할당한다.
  }) : id = uuid.v4();
}