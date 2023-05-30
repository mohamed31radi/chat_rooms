import 'package:chat_app/base.dart';
import 'package:chat_app/database_utils/database_utils.dart';
import 'package:chat_app/models/room.dart';
import 'package:chat_app/screens/create_room/create_room_navigator.dart';

class CreateRoomViewModel extends BaseViewModel<CreateRoomNavigator> {
  void addRoomToFB(String title, String description, String categoryId) {
    Room room =
        Room(title: title, description: description, categoryId: categoryId);
    DatabaseUtils.addRoomToFireStore(room).then((value) {
      navigator!.roomCreated();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}
