import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/model/produits.dart';
import 'package:flutter/material.dart';

class HomeFragmentScreen extends StatelessWidget {
  Future<List<Produits>> getAllProduitsItems() async {
    List<Produits> allProduitsItems = [];

    try {
      var res = await http.post(Uri.parse(API.getAllProduits));

      if (res.statusCode == 200) {
        var responseBodyOfAllProduits = jsonDecode(res.body);
        if (responseBodyOfAllProduits["success"] == true) {
          (responseBodyOfAllProduits["ProduitsItemsData"] as List).forEach(
            (eachRecord) {
              allProduitsItems.add(Produits.fromJson(eachRecord));
            },
          );
        } else {
          Fluttertoast.showToast(msg: "Erreur, success n'est pas true");
        }
      } else {
        Fluttertoast.showToast(msg: "Erreur, status code n'est pas 200");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Erreur: $e");
    }

    return allProduitsItems;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home fragment screen"),
      ),
    );
  }
 }