import 'dart:convert';

import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/controllers/panier_liste_controller.dart';
import 'package:ecf_studi2/users/model/panier.dart';
import 'package:ecf_studi2/users/model/produits.dart';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PanierListe extends StatefulWidget {
  @override
  State<PanierListe> createState() => _PanierListeState();
}

class _PanierListeState extends State<PanierListe> {
  late final CurrentUser currentOnlineUser;
  late final PanierListeController panierListeController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentOnlineUser = Get.put(CurrentUser());
    panierListeController = Get.put(PanierListeController());
    getCurrentUserPanierListe(); // Call the method to fetch user's panier list
  }

  getCurrentUserPanierListe() async {
    List<Panier> panierOfCurrentUser = [];

    try {
      var res = await http.post(
        Uri.parse(API.getPanierListe),
        body: {
          "currentOnlineUserID": currentOnlineUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var responseBodyOfGetCurrentUserPanierItems = jsonDecode(res.body);

        if (responseBodyOfGetCurrentUserPanierItems['success'] == true) {
          (responseBodyOfGetCurrentUserPanierItems['currentUserPanierData']
                  as List)
              .forEach((eachCurrentUserPanierItem) {
            panierOfCurrentUser.add(Panier.fromJson(eachCurrentUserPanierItem));
          });
        } else {
          Fluttertoast.showToast(msg: "erreur lors de l'execution du Query");
        }

        // Use instance of PanierListeController to set the list
        panierListeController.setList(panierOfCurrentUser);
      } else {
        Fluttertoast.showToast(msg: "la code status n'est pas 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error ::" + errorMsg.toString());
    }
    calculerQuantiteTotal();
  }

  void calculerQuantiteTotal() {
    panierListeController.setTotal(0); // Use instance of PanierListeController
    if (panierListeController.selectedItem.length > 0) {
      panierListeController.listePanier.forEach((iteminPanier) {
        if (panierListeController.selectedItem
            .contains(iteminPanier.produit_id)) {
          double eachItemQuantiteTotal = (iteminPanier.prix!) *
              (double.parse(iteminPanier.quantite.toString()));
          panierListeController
              .setTotal(panierListeController.total * eachItemQuantiteTotal);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
          () => panierListeController.listePanier.length > 0
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: panierListeController.listePanier.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Panier panierModel =
                              panierListeController.listePanier[index];

                          Produits produitsModel = Produits(
                            item_id: panierModel.produit_id,
                            image: panierModel.image,
                            prix: panierModel.prix,
                            categorie: panierModel.categorie,
                            description: panierModel.description,
                            libelle: panierModel.libelle,
                          );

                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                GetBuilder(
                                  init: PanierListeController(),
                                  builder: (c) {
                                    return IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        panierListeController.selectedItem
                                                .contains(
                                                    panierModel.produit_id)
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color:
                                            panierListeController.isSelectedAll
                                                ? Colors.white
                                                : Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                        0,
                                        index == 0 ? 16 : 8,
                                        16,
                                        index ==
                                                panierListeController
                                                        .listePanier.length -
                                                    1
                                            ? 16
                                            : 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 6,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      produitsModel.libelle
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),

                                                  const SizedBox(
                                                    height: 20,
                                                  ),

                                                  //prix
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 12,
                                                                right: 12.0),
                                                        child: Text(
                                                          "\€" +
                                                              produitsModel.prix
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors
                                                                .purpleAccent,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width - 16, 50)),
                        onPressed: isLoading
                            ? () {}
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await orderNow();

                                setState(() {
                                  isLoading = false;
                                });
                              },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Order Now",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : const Center(
                  child: Text("Le panier est vide"),
                ),
        ));
  }

  orderNow() {
    List<int> productIds = panierListeController.listePanier
        .map((e) => e.produit_id ?? 0)
        .toList();
    List<int> productQuantities =
        panierListeController.listePanier.map((e) => e.quantite ?? 0).toList();

    try {
      http.post(
        Uri.parse(API.orderNow),
        body: {
          "user_id": currentOnlineUser.user.id.toString(),
          "product_id": productIds.toString(),
          "product_quantity": productQuantities.toString(),
        },
      ).then((res) async {
        if (res.statusCode == 200) {
          var responseBodyOfOrderNow = jsonDecode(res.body);
          if (responseBodyOfOrderNow['success'] == true) {
            Fluttertoast.showToast(msg: "Order Successfull");
            panierListeController.clearAllSelectedItem();
            await getCurrentUserPanierListe();
            Navigator.of(context).pop();
          } else {
            Fluttertoast.showToast(msg: "Error while creating order");
          }
        } else {
          Fluttertoast.showToast(msg: "Error while creating order");
        }
      });
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error ::" + errorMsg.toString());
    }
  }
}
