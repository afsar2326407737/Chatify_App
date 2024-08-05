import 'package:chatapplication/Service/authantication.dart';
import 'package:chatapplication/pages/Login.dart';
import 'package:chatapplication/pages/chatPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUserList(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        "Chatify",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              await AuthServices().signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            icon: Icon(Icons.logout))
      ],
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child:
                    Text('No users available')); // Display message if no users
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all the user which connect to this user
    if (_auth.currentUser!.email != data['email']) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: const Color.fromARGB(255, 65, 65, 65),
          width: 1.0,
        )),
        child: ListTile(
          title: Text(
            data['name'],
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          reciverUserEmail: data['email'],
                          reciverUserID: data['uid'],
                          reciverUsername: data['name'],
                        )));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
