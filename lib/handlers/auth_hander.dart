import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class AuthHandeler {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  //register user to database
  Future<bool> registerUser({required User user}) async {
    try {
      final res = await users.add(user.toMap());
      log(res.toString());
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

  //get current userData()
  Future<User?> getData({required String email}) async {
    try {
      final res = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (res.docs.isNotEmpty) {
        return User.fromMap(res.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
