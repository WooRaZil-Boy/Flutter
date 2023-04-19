// 데이터를 저장하기 위한 청사진으로 widget일 필요가 없다.
class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(
    this.text,
    this.answers,
  );
}
