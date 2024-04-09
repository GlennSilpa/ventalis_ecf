import 'dart:convert';

import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/controllers/order_liste_controller.dart';
import 'package:ecf_studi2/users/model/order.dart';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderFragmentScreen extends StatefulWidget {
  @override
  State<OrderFragmentScreen> createState() => _OrderFragmentScreenState();
}

class _OrderFragmentScreenState extends State<OrderFragmentScreen> {
  late final CurrentUser currentOnlineUser;
  late final OrderListeController orderListeController;

  @override
  void initState() {
    super.initState();

    orderListeController = Get.put(OrderListeController());
    getOrderList();
  }

  void getOrderList() async {
    List<Order> ordersList = [];
    await Future.delayed(Duration(seconds: 2));
    currentOnlineUser = Get.find<CurrentUser>();

    try {
      var res = await http.post(
        Uri.parse(API.orderListe),
        body: {
          "user_id": currentOnlineUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var responseBodyOfGetCurrentUserPanierItems = jsonDecode(res.body);

        if (responseBodyOfGetCurrentUserPanierItems['success'] == true) {
          (responseBodyOfGetCurrentUserPanierItems['OrdersItemData'] as List)
              .forEach((item) {
            ordersList.add(Order.fromJson(item));
          });
        } else {
          Fluttertoast.showToast(msg: "erreur lors de l'execution du Query");
        }

        // Use instance of PanierListeController to set the list
        orderListeController.setList(ordersList);
      } else {
        Fluttertoast.showToast(msg: "la code status n'est pas 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error ::" + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return orderListeController.listeOrder.isEmpty
            ? Center(
                child: Text("Aucune commande n'a été passée"),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Liste des commandes", style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderListeController.listeOrder.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: Colors.grey[200],
                              title: Text(
                                  "Order No. ${orderListeController.listeOrder[index].id}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      "Total Prod: ${orderListeController.listeOrder[index].productId?.split(",").length}"),
                                  Text(
                                      "Total Qty: ${getQuantity(orderListeController.listeOrder[index].productQuantity ?? "")}"),
                                  // const Text(
                                  //   "Total: \$45",
                                  //   style: TextStyle(fontSize: 16),
                                  // ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //     "Status: ${orderListeController.listeOrder[index].status}"),
                                  Text(
                                      "Date: ${convertDate(orderListeController.listeOrder[index].createdAt ?? DateTime.now())}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  getQuantity(String quantity) {
    List<String> quantityList = quantity.split(",");
    int quantityTotal = 0;
    for (int i = 0; i < quantityList.length; i++) {
      if (i == 0) {
        quantityList[i] = quantityList[i].substring(1);
        quantityTotal += int.parse(quantityList[i]);
      } else if (i == quantityList.length - 1) {
        quantityList[i] =
            quantityList[i].substring(0, quantityList[i].length - 1);
        quantityTotal += int.parse(quantityList[i]);
      } else {
        quantityTotal += int.parse(quantityList[i]);
      }
    }
    return quantityTotal;
  }

  //convert the date to a readable format
  String convertDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
