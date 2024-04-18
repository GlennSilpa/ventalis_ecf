import 'dart:convert';

import 'package:ecf_studi2/admins/message_page.dart';
import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/model/chat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<ChatResponse> chats = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            "Chat List",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: ListTile(
                            onTap: () {
                              // Navigate to the chat page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagePage(
                                            chat: chats[index],
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: Colors.grey[200],
                            leading: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                )),
                            title: Text(chats[index].userData!.username),
                            subtitle: Text(chats[index].lastMessage!.message ??
                                "No message found"),
                            trailing: Text(getFormattedDate(
                                chats[index].lastMessage!.createdAt!)),
                          ),
                        );
                      },
                    )),
        ],
      ),
    );
  }

  // convert DateTime.now() to readable format
  String getFormattedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }

  getChatList() async {
    // Call the API to get the chat list
    try {
      final response = await http.get(Uri.parse(API.getChats));
      if (response.statusCode == 200) {
        // If the server returns an OK response, then parse the JSON
        List<ChatResponse> chatList = chatResponseFromJson(
            jsonEncode(jsonDecode(response.body)['chats']));
        setState(() {
          chats = chatList;
          chats.sort((a, b) =>
              b.lastMessage!.createdAt!.compareTo(a.lastMessage!.createdAt!));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Failed to load chat list");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
