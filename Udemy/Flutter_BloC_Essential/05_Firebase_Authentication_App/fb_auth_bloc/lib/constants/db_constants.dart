import 'package:cloud_firestore/cloud_firestore.dart';

// sign up 했을 떄 유저의 정보를 별도의 collection으로 저장한다.
final usersRef = FirebaseFirestore.instance.collection('users');
