import 'dart:async';
import 'dart:convert';

import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/model/chat.dart';
import 'package:ecf_studi2/users/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MessagePage extends StatefulWidget {
  MessagePage({super.key, required this.chat});

  final ChatResponse chat;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String currentUserId = "1";

  List<MessageModel> messages = [];

  final TextEditingController _controller = TextEditingController();

  bool isSending = false;

  bool isLoading = true;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // currentUserId = Get.put(CurrentUser()).user.id.toString();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      getMessagesByChatId();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.chat.userData!.username,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment:
                            currentUserId == messages[index].senderId
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          ChatBubble(
                            clipper: ChatBubbleClipper1(
                                type: currentUserId == messages[index].senderId
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble),
                            alignment: currentUserId == messages[index].senderId
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 20),
                            backGroundColor:
                                currentUserId == messages[index].senderId
                                    ? Colors.blue
                                    : Colors.grey.shade500,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Text(
                                messages[index].message ?? "",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              convertDateTime(
                                  messages[index].createdAt ?? DateTime.now()),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Type a message",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (_controller.text.trim().isNotEmpty) {
                              setState(() {
                                isSending = true;
                              });
                              String chatId = messages.isEmpty
                                  ? "0"
                                  : messages[0].chatId.toString();
                              await sendMessage(_controller.text.trim(), "1",
                                  chatId, DateTime.now());
                              //send Message
                              _controller.clear();

                              setState(() {
                                isSending = false;
                              });
                            }
                          },
                          icon: isSending
                              ? CircularProgressIndicator()
                              : Icon(Icons.send)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  //convert DateTime.now() to DD/MM/YYYY HH:MM:SS
  String convertDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }

  getMessagesByChatId() async {
    //get messages by senderId
    try {
      final response =
          await http.post(Uri.parse(API.getMessagesByChatId), body: {
        "chat_id": widget.chat.id,
      });
      if (response.statusCode == 200) {
        final List<MessageModel> messagesList = messageModelFromJson(
            jsonEncode(jsonDecode(response.body)['messages']));
        setState(() {
          messages = messagesList.reversed.toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  sendMessage(String message, String receiverId, String chatId,
      DateTime createdAt) async {
    //get messages by senderId
    try {
      final response = await http.post(Uri.parse(API.sendMessage), body: {
        "sender_id": currentUserId.toString(),
        "receiver_id": receiverId,
        "chat_id": chatId,
        "message": message,
        "created_at": createdAt.toIso8601String(),
      });
      if (response.statusCode == 200) {
        setState(() {
          messages = messages.reversed.toList();
          messages.add(
            MessageModel(
              senderId: currentUserId.toString(),
              receiverId: receiverId,
              chatId: chatId,
              message: message,
              createdAt: createdAt,
            ),
          );
          messages = messages.reversed.toList();
          isSending = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }
}
