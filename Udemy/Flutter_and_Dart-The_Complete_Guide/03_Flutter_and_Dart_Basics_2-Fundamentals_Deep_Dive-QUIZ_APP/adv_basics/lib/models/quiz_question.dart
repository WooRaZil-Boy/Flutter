// 데이터를 저장하기 위한 청사진으로 widget일 필요가 없다.
class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(
    this.text,
    this.answers,
  );

  // 리스트의 순서를 섞기 위해서는 단순히 List에 shuffle을 사용하면 된다. 하지만, shuffle은 기존의 리스트를 바꾼다.
  // 여기서는 기존의 리스트를 수정하지 않고 싶기 때문에 리스트를 복사한 다음 shuffle을 사용한다.
  List<String> getShuffledAnswers() {
    // of를 사용하면 해당 리스트에 기반한 새로운 리스트를 생성한다.
    // shuffle은 따로 목록을 반환하지 않고 기존의 리스트를 섞는다.

    // 기존의 리스트 객체에 접근하여 항목을 수정하기 때문에 재할당이 아니다. 따라서 final을 사용할 수 있다.
    // 같은 메모리의 기존 겂을 수정하는 것이기 때문에 final을 사용할 수 있다.
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
