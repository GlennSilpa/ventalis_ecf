import 'package:ecf_studi2/users/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class PageContact extends StatefulWidget {
  PageContact({super.key});

  @override
  State<PageContact> createState() => _PageContactState();
}

class _PageContactState extends State<PageContact> {
  int currentUserId = 2;

  List<MessageModel> messages = [
    MessageModel(
        message: "Message 1",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 0,
        receiverId: 1,
        senderId: 2),
    MessageModel(
        message: "Message 2",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 1,
        receiverId: 1,
        senderId: 2),
    MessageModel(
        message: "Message 3",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 2,
        receiverId: 1,
        senderId: 2),
    MessageModel(
        message: "Message 4",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 3,
        receiverId: 1,
        senderId: 2),
    MessageModel(
        message: "Message 5",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 4,
        receiverId: 1,
        senderId: 2),
    MessageModel(
        message: "Message 6",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 5,
        receiverId: 1,
        senderId: 2),
    MessageModel(
        message: "Message 7",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 6,
        receiverId: 1,
        senderId: 2),
    MessageModel(
        message: "Message 8",
        chatId: 0,
        createdAt: DateTime.now(),
        id: 7,
        receiverId: 1,
        senderId: 2),
  ].reversed.toList();

  final TextEditingController _controller = TextEditingController();

  bool isSending = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Contact Page",
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
                            fillColor: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (_controller.text.trim().isNotEmpty) {
                              setState(() {
                                isSending = true;
                              });
                              await Future.delayed(Duration(seconds: 2));
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
}
