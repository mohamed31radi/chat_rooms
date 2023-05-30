import 'package:chat_app/base.dart';
import 'package:chat_app/database_utils/database_utils.dart';
import 'package:chat_app/screens/home_screen/home_navigator.dart';
import '../../models/room.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void reedRooms() {
    DatabaseUtils.readRoomFromFireStore().then((value) {
      rooms = value;
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}
