import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/chat_model.dart';

class ChatHandler {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('chats');
  //register user to database
  Future<bool> sendMessage({required Chat chat}) async {
    try {
      final res = await users.add(chat.toMap());

      if (res != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
