// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  int? id;
  int? userId;
  String? productId;
  String? productQuantity;
  String? status;
  DateTime? createdAt;

  Order({
    this.id,
    this.userId,
    this.productId,
    this.productQuantity,
    this.status,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: int.tryParse(json["id"]),
        userId: int.tryParse(json["user_id"]),
        productId: json["product_id"],
        productQuantity: json["product_quantity"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "product_quantity": productQuantity,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
      };
}
