// 성공 응답 또는 오류를 보유하는 일반 응답 클래스를 만드는 것이 좋습니다.
// abstract class를 생성했습니다. 제네릭 유형 T를 가진 Result에 대한 간단한 청사진입니다.
abstract class Result<T> {

}

// Result를 확장하고 응답이 성공할 때 값을 보유하는 Success 클래스를 만들었습니다.
// 예를 들어 JSON 데이터를 저장할 수 있습니다.
class Success<T> extends Result<T> {
  final T value;

  Success(this.value);
}

// Result를 확장하고 예외를 보유하기 위해 Error 클래스를 생성했습니다.
// 이 클래스는 잘못된 자격 증명을 사용하거나 권한 없이 데이터를 가져오려고 시도하는 등 HTTP 호출 중에 발생하는 오류를 모델링합니다.
class Error<T> extends Result<T> {
  final Exception exception;

  Error(this.exception);
}