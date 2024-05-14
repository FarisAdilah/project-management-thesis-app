import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> login(LoginDM creds) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: creds.email ?? "",
        password: creds.password ?? "",
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
