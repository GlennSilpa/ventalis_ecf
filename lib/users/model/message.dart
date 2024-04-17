// To parse this JSON data, do
//
//     final MessageModel = MessageModelFromJson(jsonString);

import 'dart:convert';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  int? id;
  String? message;
  int? chatId;
  int? senderId;
  int? receiverId;
  DateTime? createdAt;

  MessageModel({
    this.id,
    this.message,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        message: json["message"],
        chatId: json["chat_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "chat_id": chatId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "created_at": createdAt?.toIso8601String(),
      };
}
