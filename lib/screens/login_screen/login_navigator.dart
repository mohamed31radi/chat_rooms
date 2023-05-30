import 'package:chat_app/base.dart';

import '../../models/app_user.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome(AppUser appUser);
}
