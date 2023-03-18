// ignore_for_file: prefer_const_constructors

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart' as user;
import '../handlers/auth_hander.dart';
import '../handlers/chat_handler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _msgController = TextEditingController();
  final chatHandler = ChatHandler();
  final authHandler = AuthHandeler();
  late user.User? currentUser;

  @override
  void initState() {
    super.initState();
    authHandler.getData(email: _auth.currentUser!.email!).then((value) {
      setState(() {
        currentUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome ${currentUser!.username} !'),
        actions: [
          TextButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, 'Login');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Something Happned Wrong!");
                } else if (snapshot.hasData) {
                  final List<Chat> chats = List.from(snapshot.data!.docs
                      .map((e) => Chat.fromMap(e.data()))
                      .toList());
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(chats[index].username!),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  BubbleSpecialThree(
                                    text: chats[index].message!,
                                    color: Color(0xFF1B97F3),
                                    tail: true,
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                } else {
                  return Text("Something Happned Wrong!");
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _msgController,
                      decoration: InputDecoration(
                          hintText: 'Type Your Msg', border: InputBorder.none),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_msgController.text == '') {
                      return;
                    } else {
                      chatHandler.sendMessage(
                          chat: Chat(
                        message: _msgController.text,
                        username: currentUser!.username,
                        createdAt: DateTime.now().toLocal().toString(),
                      ));
                      _msgController.clear();
                    }
                  },
                  icon: Icon(Icons.send),
                  iconSize: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
