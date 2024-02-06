import 'dart:convert';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/controllers/item_details_controller.dart';
import 'package:ecf_studi2/users/model/produits.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProduitsDetailsScreen extends StatefulWidget {
  final Produits? ProduitsInfo;

  ProduitsDetailsScreen({this.ProduitsInfo});

  @override
  State<ProduitsDetailsScreen> createState() => _ProduitsDetailsScreenState();
}

class _ProduitsDetailsScreenState extends State<ProduitsDetailsScreen> {
  late final ItemDetailsController itemDetailsController;

  @override
  void initState() {
    super.initState();
    itemDetailsController = Get.put(ItemDetailsController());
  }

 final currentOnlineUser = Get.find<CurrentUser>(); // Find the instance of CurrentUser

void ajouterProduitAuPanier() async {
  try {
    // Retrieve user ID from CurrentUser
    int userId = currentOnlineUser.user.id; // Assuming the user ID is stored in the 'id' field

    var res = await http.post(
      Uri.parse(API.ajouterAuPanier),
      body: {
        "user_id": currentOnlineUser.user.id.toString(), // Use the correct field to access the user ID
        "produit_id": widget.ProduitsInfo!.item_id.toString(),
        "quantité": itemDetailsController.quantity.toString(),
      },
    );

    if (res.statusCode == 200) {
      var resBodyOfAjouterPanier = jsonDecode(res.body);
      if (resBodyOfAjouterPanier['success'] == true) {
        Fluttertoast.showToast(msg: "Produit ajouté au panier.");
      } else {
        Fluttertoast.showToast(msg: "Erreur, veuillez réessayer.");
      }
    } else {
      Fluttertoast.showToast(msg: "Le statut n'est pas 200");
    }
  } catch (errorMsg) {
    print("Error :: $errorMsg");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FadeInImage(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            placeholder: const AssetImage("images/PM_utilisateurs.jpg"),
            image: NetworkImage(
              widget.ProduitsInfo!.image!,
            ),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ProduitsInfoWidget(),
          ),
        ],
      ),
    );
  }

  Widget ProduitsInfoWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.grey,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18,),
            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Text(
              widget.ProduitsInfo!.libelle!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.ProduitsInfo!.categorie!.toString().replaceAll("[", "").replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        "€" + widget.ProduitsInfo!.prix.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        widget.ProduitsInfo!.description!.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Material(
                        elevation: 4,
                        color: const Color.fromARGB(255, 68, 68, 68),
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {
                            ajouterProduitAuPanier();
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: const Text(
                              "Ajouter au panier",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
                
                  Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //ajouter quantité produit
                  IconButton(
                    onPressed: () {
                      itemDetailsController.setQuantityItem(itemDetailsController.quantity + 1);
                    },
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white,),
                  ),
                  Text(
                    itemDetailsController.quantity.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //diminuer nombre de produits
                  IconButton(
                    onPressed: () 
                    {
                    if(itemDetailsController.quantity - 1 >=1) 
                      { 
                      itemDetailsController.setQuantityItem(itemDetailsController.quantity - 1);
                     }
                     else
                     {
                      Fluttertoast.showToast(msg: "La quantité ne peut êre inférieure à 1");
                     }
                    },
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.white,),
                  ),
                ],
              ),
            ),

              ],
            ),     
          ],
        ),
      ),
    );
  }
}