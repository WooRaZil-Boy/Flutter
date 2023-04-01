// API 구조에서 값을 List 형태로 반환하는데, 그전에 List가 empty인 경우를 처리해야 한다.
// 에러가 아니긴 하지만, 여기서는 편의상 에러로 처리한다.
// 따라서 이 에러는 공통적인 에러가 아닌 Open weather의 특수한 에러일 뿐이므로 Custom Exception을 만들어 다르게 처리한다.
class WeatherException implements Exception {
  String message;

  WeatherException([
    this.message = 'Something went wrong'
  ]) {
    message = 'Weather Exception: $message';
  }

  @override
  String toString() => message;
}