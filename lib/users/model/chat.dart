// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ecf_studi2/users/model/message.dart';
import 'package:ecf_studi2/users/model/user.dart';

List<ChatResponse> chatResponseFromJson(String str) => List<ChatResponse>.from(
    json.decode(str).map((x) => ChatResponse.fromJson(x)));

String chatResponseToJson(List<ChatResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatResponse {
  String? id;
  String? senderId;
  String? receiverId;
  DateTime? createdAt;
  User? userData;
  MessageModel? lastMessage;

  ChatResponse({
    this.id,
    this.senderId,
    this.receiverId,
    this.lastMessage,
    this.createdAt,
    this.userData,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        lastMessage: json["messageData"] == null
            ? null
            : MessageModel.fromJson(json["messageData"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        userData:
            json["userData"] == null ? null : User.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "last_message": lastMessage,
        "created_at": createdAt?.toIso8601String(),
      };
}
