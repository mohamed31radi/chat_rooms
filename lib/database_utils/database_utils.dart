import 'package:chat_app/models/app_user.dart';
import 'package:chat_app/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/room.dart';

class DatabaseUtils {
  static CollectionReference<AppUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(AppUser.COLLECTION_NAME)
        .withConverter<AppUser>(
          fromFirestore: (snapshot, options) =>
              AppUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<Room> createRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return createRoomCollection()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addUserToFireStore(AppUser appUser) {
    return getUserCollection().doc(appUser.id).set(appUser);
  }

  static Future<AppUser?> readUserFromFireStore(String id) async {
    DocumentSnapshot<AppUser> user = await getUserCollection().doc(id).get();
    var appUser = user.data();
    return appUser;
  }

  static Future<void> addRoomToFireStore(Room room) {
    var collection = createRoomCollection();
    var docRef = collection.doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> readRoomFromFireStore() async {
    QuerySnapshot<Room> snapshotRoom = await createRoomCollection().get();
    return snapshotRoom.docs.map((e) => e.data()).toList();
  }

  static Future<void> deleteRoomFromFireStore(String roomId) {
    var collection = createRoomCollection();
    return collection.doc(roomId).delete();
  }

  static Future<void> addMessagesToFireStore(Message message) {
    var docRef = getMessagesCollection(message.roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessagesFromFireStore(
      String roomId) {
    return getMessagesCollection(roomId).orderBy("dateTime").snapshots();
  }
}
