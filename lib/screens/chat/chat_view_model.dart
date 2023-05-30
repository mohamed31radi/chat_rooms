import 'package:chat_app/base.dart';
import 'package:chat_app/database_utils/database_utils.dart';
import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/app_user.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late AppUser appUser;

  void sendMessage(String content) {
    Message message = Message(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        roomId: room.id,
        senderId: appUser.id,
        senderName: appUser.userName);
    DatabaseUtils.addMessagesToFireStore(message).then((value) {
      navigator!.messageUploaded();
    });
  }

  Stream<QuerySnapshot<Message>> readMessages() {
    return DatabaseUtils.readMessagesFromFireStore(room.id);
  }
}

abstract class ChatNavigator extends BaseNavigator {
  void messageUploaded();
}
