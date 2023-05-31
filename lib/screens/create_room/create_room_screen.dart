import 'package:chat_app/base.dart';
import 'package:chat_app/screens/create_room/create_room_navigator.dart';
import 'package:chat_app/screens/create_room/create_room_view_model.dart';
import 'package:chat_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/room_category.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = 'create room';

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState
    extends BaseView<CreateRoomViewModel, CreateRoomScreen>
    implements CreateRoomNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var category = RoomCategory.getCategoryList();
  late RoomCategory selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    selectedCategory = category[0];
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
                  'Chat App',
                ),
                leading: IconButton(
                    onPressed: () {
                      roomCreated();
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              body: SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.all(30),
                  elevation: 20,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.transparent)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Create New Room",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          Image.asset("assets/images/group.png"),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            controller: titleController,
                            validator: (value) {
                              if (value!.trim() == "") {
                                return "Enter Room Title";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                hintText: 'Room Title',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButton(
                            value: selectedCategory,
                            items: category
                                .map((category) =>
                                    DropdownMenuItem<RoomCategory>(
                                        value: category,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            children: [
                                              Image.asset(category.image),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(category.name),
                                            ],
                                          ),
                                        )))
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.multiline,
                            controller: descriptionController,
                            validator: (value) {
                              if (value!.trim() == "") {
                                return "Enter Description";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                hintText: 'Room Description',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                validateForm();
                              },
                              child: Text('Create')),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.addRoomToFB(titleController.text, descriptionController.text,
          selectedCategory.id);
    }
  }

  @override
  CreateRoomViewModel initViewModel() {
    return CreateRoomViewModel();
  }

  @override
  void roomCreated() {
    // TODO: implement roomCreated
    Navigator.pop(context, "refresh");
  }
}
