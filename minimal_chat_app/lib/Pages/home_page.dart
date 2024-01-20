import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Components/my_drawer.dart';
import 'package:minimal_chat_app/Services/Chat/chat_service.dart';
import 'package:minimal_chat_app/Services/auth/auth_service.dart';

import '../Components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Center(
          child: Text("HomePage"),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Text("Error");
        }

        //loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }

        // return list view
        try {
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userData) => _buildUserListItem(userData, context),
                )
                .toList(),
          );
        } catch (e) {
          throw Exception(e);
        }
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic>? userData, BuildContext context) {
    // check if userData or email is null
    if (userData == null ||
        userData["email"] == null ||
        _authService.getCurrentUser() == null) {
      return Container(); // or handle it in a way that makes sense for your app
    }

    // display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // tapped on a user => go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  // // build individual list tile for user
  // Widget _buildUserListItem(
  //     Map<String, dynamic> userData, BuildContext context) {
  //   if (userData == null || userData["email"] == null) {
  //     return Container(); // or handle it in a way that makes sense for your app
  //   }
  //   // display all users except current user
  //   return UserTile(
  //     text: userData["email"],
  //     onTap: () {
  //       // tapped o a user => go to chat page
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ChatPage(
  //             receiverEmail: userData["email"],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
