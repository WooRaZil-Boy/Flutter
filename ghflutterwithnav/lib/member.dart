//Parsing to Custom Types
//멤버 리스트(map, Kotlin에서도 Map, Swift에서는 Dictionary와 같다)에 사용자 정의 유형을 사용할 수 있다.
class Member { //Widget이 아닌 Dart로 생성한 DTO
  final String login;
  final String avatarUrl;

  Member(this.login, this.avatarUrl) { //생성자
    if (login == null) {
      throw new ArgumentError("login of Member cannot be null."
        "Received: '$login'"); //로그인 값이 null인 경우, 오류를 throw한다.
    }

    if (avatarUrl == null) {
      throw new ArgumentError("avatarUrl of Member cannot be null. "
          "Received: '$avatarUrl'"); //아바타 이미지가 null인 경우, 오류를 throw한다.
    }
  }
}

//Hot reload로 실행 시 종종 코드에 오류가 없는 경우에도 error가 throw 되는 경우가 있다.
//이런 경우에는 build 자체를 다시(F5)하면 된다.
