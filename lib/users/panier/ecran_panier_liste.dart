import 'dart:convert';

import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/model/panier.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ecf_studi2/users/controllers/panier_liste_controller.dart';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:http/http.dart' as http;

class PanierListe extends StatefulWidget {
  @override
  State<PanierListe> createState() => _PanierListeState();
}

class _PanierListeState extends State<PanierListe> {
  late final CurrentUser currentOnlineUser;
  late final PanierListeController panierListeController;

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
            panierOfCurrentUser
                .add(Panier.fromJson(eachCurrentUserPanierItem));
          });
        } else {
          Fluttertoast.showToast(
              msg: "erreur lors de l'execution du Query");
        }

        // Use instance of PanierListeController to set the list
        panierListeController.setList(panierOfCurrentUser);
      } else {
        Fluttertoast.showToast(msg: "la code status n'est pas 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error ::" + errorMsg.toString());
    }
  }

  calculerQuantiteTotal()
  {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon appli'),
      ),
      body: Center(
        child: Text("elements de l'UI ici"),
      ),
    );
  }
}