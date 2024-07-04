// class는 실제 인스턴스가 아닌 설계도

class Bank{
  final String name;
  final String logoImagePath;

  Bank(this.name, this.logoImagePath);

  @override
  String toString() {
    return name;
  }

  // ==를 재정의한다. @freezed를 사용하면, ==와 hashCode를 자동으로 생성해준다.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other.runtimeType != runtimeType) return false;
  
    return other is Bank &&
      other.name == name;
  }
}