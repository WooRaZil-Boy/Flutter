class SimpleStock {
  final String name;

  SimpleStock(this.name);

  // json object로 객체를 생성하므로 factory 키워드가 필요하다. 
  // factory는 생성자와 유사한 역할을 하며, 가공할 수 있는 파라미터로 필요한 생성자를 호출하여 객체를 돌려준다.
  factory SimpleStock.fromJson(dynamic json) {
    return SimpleStock(json['name']);
  }
}
