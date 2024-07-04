// class에 함수를 추가할 때, extension이라는 키워드를 사용한다.
// ListExtension은 이름이고, on으로 확장할 클래스를 지정한다.
// 이미 있는 class라도 필요한 함수가 없다면, extension으로 추가할 수 있다.
extension ListExtension on List {
  void swap(int origin, int target) {
    final temp = this[origin];
    this[origin] = this[target];
    this[target] = temp;
  }
}