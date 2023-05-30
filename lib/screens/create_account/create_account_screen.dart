import 'package:chat_app/base.dart';
import 'package:chat_app/models/app_user.dart';
import 'package:chat_app/providers/current_user.dart';
import 'package:chat_app/screens/create_account/navigator.dart';
import 'package:chat_app/screens/create_account/create_account_view_model.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:chat_app/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = 'create account';

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends BaseView<CreateAccountViewModel, CreateAccountScreen>
    implements createAccountNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var userNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/main_ground.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  'Create Account',
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .30,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: firstNameController,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.trim() == "") {
                                    return "Please Enter First Name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    hintText: 'First Name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: userNameController,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.trim() == "") {
                                    return "Please Enter User Name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    hintText: 'User Name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: emailController,
                                validator: (value) {
                                  if (value!.trim() == "") {
                                    return "Please Enter E-mail";
                                  }
                                  final bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value);
                                  if (!emailValid) {
                                    return "Please Enter Valid E-mail";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    hintText: 'E-mail',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.trim() == "") {
                                    return "Please Enter Password";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ))),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: Text('Create Acount')),
                      SizedBox(
                        height: 8,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: Text('I Have an Account'))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.CreateAccountWithFirebaseAuth(
          emailController.text,
          passwordController.text,
          userNameController.text,
          firstNameController.text);
    }
  }

  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(AppUser appUser) {
    Provider.of<GetCurrentUser>(context, listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
