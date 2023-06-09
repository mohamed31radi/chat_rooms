import 'package:chat_app/models/room.dart';
import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  HomeViewModel viewModel;

  RoomWidget(this.room, this.viewModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                  color: Colors.grey.withOpacity(.5))
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      viewModel.deleteRoom(room);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.blueAccent,
                    )),
              ],
            ),
            Expanded(
                child: Image.asset("assets/images/${room.categoryId}.png")),
            SizedBox(
              height: 5,
            ),
            Text(room.title,
                style: TextStyle(
                  fontSize: 16,
                )),
          ],
        ),
      ),
    );
  }
}
