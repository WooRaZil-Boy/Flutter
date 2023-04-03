import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_bloc/constants/db_constants.dart';
import 'package:fb_auth_bloc/models/custom_error.dart';
import 'package:fb_auth_bloc/models/user_model.dart';

class ProfileRepository {
  // FirebaseFirestore에 접근해야 한다.
  final FirebaseFirestore firebaseFirestore;

  ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<User> getProfile({required String uid}) async {
    try {
      // FirebaseFirestore에서 값을 가져온다.
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();

      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }

      throw 'User not found';
    } on FirebaseException catch (e) {
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
}