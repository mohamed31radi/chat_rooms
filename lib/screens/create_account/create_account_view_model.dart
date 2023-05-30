import 'package:chat_app/base.dart';
import 'package:chat_app/database_utils/database_utils.dart';
import 'package:chat_app/models/app_user.dart';
import 'package:chat_app/screens/create_account/navigator.dart';
import 'package:chat_app/shared/component/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CreateAccountViewModel extends BaseViewModel<createAccountNavigator> {
  String message = '';

  void CreateAccountWithFirebaseAuth(
      String email, String password, String userName, String firstName) async {
    try {
      navigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = 'Account Created';
      AppUser appUser = AppUser(
          id: credential.user?.uid ?? "",
          firstName: firstName,
          userName: userName,
          email: email);
      DatabaseUtils.addUserToFireStore(appUser).then((value) {
        navigator!.hideDialog();
        navigator!.goToHome(appUser);
        return;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        message = 'The password provided is too weak.';
      } else if (e.code == FirebaseErrors.emailInUse) {
        message = 'The account already exists for that email.';
      }
    } catch (e) {
      message = "Something Wont Wrong:$e";
    }
    if (message != '') {
      navigator!.hideDialog();
      navigator!.showMessage(message);
    }
  }
}
