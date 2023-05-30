import 'package:chat_app/base.dart';
import 'package:chat_app/models/app_user.dart';
import 'package:chat_app/screens/chat/chat_view_model.dart';
import 'package:chat_app/screens/chat/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/messages.dart';
import '../../models/room.dart';
import '../../providers/current_user.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatViewModel, ChatScreen>
    implements ChatNavigator {
  var messagesController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var currentUser = Provider.of<GetCurrentUser>(context);
    viewModel.appUser = currentUser.appUser ??
        AppUser(id: '', firstName: "", userName: "", email: "");
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
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
              room.title,
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 5,
                      color: Colors.grey.withOpacity(.5))
                ]),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.readMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went Wrong"),
                      );
                    }
                    var messages =
                        snapshot.data?.docs.map((e) => e.data()).toList();
                    return ListView.builder(
                      itemCount: messages?.length ?? 0,
                      itemBuilder: (context, index) {
                        return MessageWidget(messages![index]);
                      },
                    );
                  },
                )),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: messagesController,
                        decoration: InputDecoration(
                          hintText: "Type a Message",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.black45)),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.only(topRight: Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        viewModel.sendMessage(messagesController.text);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  color: Colors.blue.withOpacity(.5))
                            ]),
                        child: Row(
                          children: [
                            Text("Send",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void messageUploaded() {
    messagesController.clear();
    setState(() {});
  }
}
