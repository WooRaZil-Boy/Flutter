import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import 'package:fb_auth_bloc/constants/db_constants.dart';
import 'package:fb_auth_bloc/models/custom_error.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  // Firebase Auth 인스턴스에서 유저 상태에 대한 정보를 Stream으로 알려주는 함수이다.
  // getter를 만들어 편리하게 접근할 수 있도록 한다.
  // Auth 상태가 바뀔 때마다 알려주므로, listen 후 적절하게 조치하면 된다.
  // ex. 로그아웃이 되면, User는 null이 된다. 
  // 이외에도 회원가입, 로그인, 로그아웃, 토큰 만료등의 경우 User의 상태가 변하고 스트림으로 전달된다.
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  // email, password 만 있으면 되지만, name을 받아 firestore에 User collection을 만들어 FirebaseAuth에는 저장할 수 없는 별도의 정보를 저장한다. 
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 이 함수는 성공적으로 작동하면, UserCredential을 반환하고 동시에 로그인이 된다.
      // 또 유저의 상태가 바뀌었기 때문에 user getter의 값도 변한다.
      final fbAuth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 여기서는 userCredential가 성공해서 non-null 이므로 !를 사용한다.
      final signedInUser = userCredential.user!;

      // User를 collection에 저장한다.
      await usersRef.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        // 여기서는 랜덤하게 생성된 이미지를 사용하지만, 실제로는 DB에 저장해 둬야 한다.
        'profileImage': 'https://picsum.photos/300',
        'point': 0,
        'rank': 'bronze',
      });
    } on fbAuth.FirebaseAuthException catch (e) {
      // 여기서 error를 throw 해서 에러의 처리를 호출한 쪽에 맡긴다.
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) { 
      // 일반 에러
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      // 이 함수가 성공적으로 작동하면 로그인 된다.
      // 또 유저의 상태가 바뀌었기 때문에 user getter의 값도 변한다.
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signout() async {
    // 이 함수가 성공적으로 작동하면 로그아웃 된다.
    // 또 유저의 상태가 바뀌었기 때문에 user getter의 값도 변한다.
    await firebaseAuth.signOut();
  }
}
