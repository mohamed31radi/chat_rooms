import 'package:chat_app/database_utils/database_utils.dart';
import 'package:chat_app/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetCurrentUser extends ChangeNotifier {
  AppUser? appUser;
  User? firebaseUser;

  GetCurrentUser() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initAppUser();
    }
  }

  void initAppUser() async {
    appUser =
        await DatabaseUtils.readUserFromFireStore(firebaseUser?.uid ?? "");
  }
}
