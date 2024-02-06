import 'dart:convert';
import 'package:ecf_studi2/users/item/produits_details_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  Widget allItemWidget(BuildContext context) {
    return FutureBuilder(
      future: getAllProduitsItems(),
      builder: (context, AsyncSnapshot<List<Produits>> dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapshot.data == null) {
          return Center(
            child: Text("Aucun produit n'a été trouvé"),
          );
        }
        if (dataSnapshot.data!.length > 0) {
          return ListView.builder(
            itemCount: dataSnapshot.data!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Produits eachProduitsItemRecords = dataSnapshot.data![index];

              return GestureDetector(
                onTap: () {
                  Get.to(ProduitsDetailsScreen(ProduitsInfo: eachProduitsItemRecords));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    16,
                    index == dataSnapshot.data!.length - 1 ? 16 : 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.white,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: 
                                    
                                    //libelle
                                    Text(
                                      eachProduitsItemRecords.libelle ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  
                                  //prix
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                    child: Text(
                                       "€" + eachProduitsItemRecords.prix.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16,),

                                //categorie
                                Text(
                                    "Catégorie: " + eachProduitsItemRecords.categorie.toString().replaceAll("[", "").replaceAll("]", ""),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                            ],
                          ),
                        ),
                      ),
                    
                         //image produit
                         ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ), 
                           child: FadeInImage(
                            height: 150,
                            width: 200,
                            fit: BoxFit.cover,
                            placeholder: const AssetImage("images/PM_utilisateurs.jpg"),
                            image: NetworkImage(
                              eachProduitsItemRecords.image!,
                            ),
                            imageErrorBuilder: (context, error, stackTraceError)
                            {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                ),
                              );
                            }
                           ),
                         )



                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text("Vide, aucune donné"),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Other widgets can be added here
          allItemWidget(context),
        ],
      ),
    );
  }
}