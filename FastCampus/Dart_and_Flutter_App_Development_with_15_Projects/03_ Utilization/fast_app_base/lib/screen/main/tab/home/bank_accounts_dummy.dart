import 'package:fast_app_base/screen/main/tab/home/banks_dummy.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank_account.dart';

final bankAccountShinhan1 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan2 = BankAccount(bankShinhan, 30000000, accountTypeName: "저축예금");
final bankAccountShinhan3 = BankAccount(bankShinhan, 300000000, accountTypeName: "저축예금");
final bankAccountToss = BankAccount(bankTtoss, 5000000);
final bankAccountKakao = BankAccount(bankKakao, 7000000, accountTypeName: "입출금통장");

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