import 'package:fast_app_base/screen/main/tab/home/banks_dummy.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank_account.dart';

final bankAccountShinhan1 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan2 = BankAccount(bankShinhan, 30000000, accountTypeName: "저축예금");
final bankAccountShinhan3 = BankAccount(bankShinhan, 300000000, accountTypeName: "저축예금");
final bankAccountToss = BankAccount(bankTtoss, 5000000);
final bankAccountKakao = BankAccount(bankKakao, 7000000, accountTypeName: "입출금통장");
final bankAccountKakao2 = BankAccount(bankKakao, 1000000, accountTypeName: "특별통장");

// 필요하면 여기서 이런 식으로 main 함수를 만들어서 테스트해볼 수 있다.
// run을 누르면 flutter로 에뮬레이터가 실행된다. 해당 파일만 console로 실행해 보려면
// 터미널에 dart run path/to/your/file/bank_accounts_dummy.dart 를 입력하면 된다.
// 바로 실행이 안 되거나 에러나 나는 것을 확인하여 병목을 찾아낼 수 있다.
main() {
  //print(bankAccounts[3].accountTypeName);
  //
  // for (final item in bankAccounts) {
  //   print(item.accountTypeName);
  // }
  // final shinhanBank = bankMap["shinhan1"];
  // //print(shinhanBank ==bankAccountShinhan1);
  //
  // for (final entry in bankMap.entries) {
  //   print(entry.key + ":" + (entry.value.accountTypeName ?? entry.value.bank.name));
  // }
  //
  //print(bankSet.length);

  // Abstract class
  final dog1 = Dog();
  final dog2 = Dog();
  final dog3 = Dog();
  final dog4 = Dog();

  final cat1 = Cat();
  final cat2 = Cat();
  final cat3 = Cat();
  
  final cow1 = Cow();

  // Animal 타입으로 추론한다.
  final list = [dog1, dog2, dog3, dog4, cat1, cat2, cat3, cow1];
  for (final animal in list) {
    // if (animal is Dog) {
    //   animal.eat();
    // } else {
    //   // cow는 Cat으로 캐스팅이 안 되기 때문에, as로 캐스팅하면 에러가 난다.
    //   (animal as Cat).eat();
    // }

    // abstract class로 선언했기 때문에, 하나의 Animal로 다룰 수 있다.
    animal.eat();
  }

  for (final account in bankAccounts) {
    print(account.toString());
  }

  // HashMap에서 putIfAbsent를 사용하면, key가 없을 때만 value를 추가한다.
  // 제네릭을 사용할 때, T extends V 라는 식으로 사용하여, V 클래스를 특정하게 지정해 줄 수 있다.

  //class generic

  final result = doTheWork();
  final result2 = doTheWork2();

  //method or function generic

  final result3 = doTheWork3<Dog>(() => Dog());
  result3.eat();
}

// abstract로 선언하면, 객체화할 수 없다. protocol이나 interface로 생각하면 된다.
// Animal을 상속받는 클래스는 eat 함수를 구현해야 한다.
abstract class Animal {
  void eat();
}

class Dog extends Animal {
  void eat() {
    print('dog');
  }
}

class Cat extends Animal {
  void eat() {
    print('cat');
  }
}

class Cow extends Animal {
  void eat() {
    print('cow');
  }
}

class Result<T> {
  final T data;

  Result(this.data);
}

class ResultString {
  final String data;

  ResultString(this.data);
}

class ResultDouble {
  final double data;

  ResultDouble(this.data);
}

Result doTheWork3<Result extends Animal>(Result Function() animalCreator) {
  return animalCreator();
}

Result<String> doTheWork() {
  ///...1
  ///...2
  ///
  /// ..4
  return Result("중요한 데이터");
}

ResultDouble doTheWork2() {
  ///...1
  ///...2
  ///
  /// ..4
  return ResultDouble(5234.44);
}

//List
final bankAccounts = [
  bankAccountShinhan1,
  bankAccountShinhan1,
  bankAccountShinhan1,
  bankAccountShinhan1,
  bankAccountShinhan1,
  bankAccountShinhan1,
  bankAccountShinhan1,
  bankAccountShinhan2,
  bankAccountShinhan3,
  bankAccountToss,
  bankAccountKakao
];

//Map
final bankMap = {
  "shinhan1": bankAccountShinhan1,
  "shinhan2": bankAccountShinhan2,
};

//Set
final bankSet = {bankAccountShinhan1,
  bankAccountShinhan2,
  bankAccountShinhan2,
  bankAccountShinhan2,
  bankAccountShinhan2,
  bankAccountShinhan3,
  bankAccountToss,
  bankAccountKakao};