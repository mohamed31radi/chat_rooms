import 'package:chat_app/base.dart';
import 'package:chat_app/models/app_user.dart';

abstract class createAccountNavigator extends BaseNavigator {
  void goToHome(AppUser appUser);
}
