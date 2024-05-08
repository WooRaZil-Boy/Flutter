import 'vo_bank.dart';

class BankAccount {
  final Bank bank;
  int balance; // 잔액은 계속 바뀌기 때문에 final이 아니다.
  final String? accountTypeName;

  BankAccount(
    this.bank,
    this.balance, {
    this.accountTypeName, // accountTypeName은 optional 이므로 required가 아니다.
  });

  // BankAccount({
  //   required this.bank,
  //   required this.balance,
  //   this.accountTypeName,
  // });
  // required을 사용하면 위와 같이 쓸 수 있다.
}
