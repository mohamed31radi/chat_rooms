import 'package:chat_app/providers/current_user.dart';
import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/screens/create_account/create_account_screen.dart';
import 'package:chat_app/screens/create_room/create_room_screen.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:chat_app/screens/login_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => GetCurrentUser(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetCurrentUser>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      routes: {
        ChatScreen.routeName: (context) => ChatScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        CreateRoomScreen.routeName: (context) => CreateRoomScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
