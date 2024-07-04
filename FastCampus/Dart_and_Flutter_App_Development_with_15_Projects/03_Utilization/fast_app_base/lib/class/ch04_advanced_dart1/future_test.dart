import 'dart:async';

import 'package:fast_app_base/screen/main/tab/home/bank_accounts_dummy.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank_account.dart';

void main() async {
  //Future의 기본 개념
  ///Future == 미래
  ///시간이 걸리는 Computation 작업 또는 유저의 응답을 기다려야되는 상태

  //Future의 생성과 수행

  //Future Timeout

  //Future Error handling

  //FutureOr
}

List<BankAccount> getBackAccounts() {
  return bankAccounts;
}

Future sleepAsync(Duration duration) {
  return Future.delayed(duration, () {
    
  });
}