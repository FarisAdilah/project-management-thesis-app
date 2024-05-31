import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class AuthenticationRepository {
  static AuthenticationRepository get instance => AuthenticationRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Authentication Operation
  Future<UserDM?> login(LoginDM creds) async {
    try {
      Helpers.writeLog("credential request: ${jsonEncode(creds)}");
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: creds.email ?? "",
        password: creds.password ?? "",
      );
      User? user = userCredential.user;
      UserDM userDM = UserDM();
      userDM.email = user?.email;
      userDM.id = user?.uid;
      userDM.password = creds.password;

      Helpers().showSuccessSnackBar(
        "Login Successful",
        position: SnackPosition.TOP,
      );
      return userDM;
    } on FirebaseAuthException catch (e) {
      String message = "";
      Helpers.writeLog(e.code);
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email provided.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid credential provided.';
      }
      Helpers().showErrorSnackBar(message, position: SnackPosition.TOP);
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Helpers().showSuccessSnackBar(
        "Logout Berhasil",
        position: SnackPosition.TOP,
      );
    } catch (e) {
      Helpers.writeLog("error: ${e.toString()}");
    }
  }

  Stream<UserDM?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  UserDM? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      UserDM userDM = UserDM();
      userDM.id = user.uid;
      userDM.email = user.email;
      return userDM;
    }
  }
}
