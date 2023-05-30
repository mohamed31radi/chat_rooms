import 'package:chat_app/base.dart';
import 'package:chat_app/database_utils/database_utils.dart';
import 'package:chat_app/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_navigator.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  String message = '';

  void loginWithFirebaseAuth(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = 'Successfully Logged';
      AppUser? appUser =
          await DatabaseUtils.readUserFromFireStore(credential.user?.uid ?? "");
      if (appUser != null) {
        navigator!.hideDialog();
        navigator!.goToHome(appUser);
        return;
      }
    } on FirebaseAuthException catch (e) {
      message = 'Wrong E-mail or Password';
    } catch (e) {
      message = e.toString();
    }
    if (message != '') {
      navigator!.hideDialog();
      navigator!.showMessage(message);
    }
  }
}
