import 'package:ecf_studi2/api_connection/api_connection.dart';
import 'package:ecf_studi2/users/model/produits.dart';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class ProduitsDetailsScreen extends StatefulWidget 
{

final Produits? ProduitsInfo;

ProduitsDetailsScreen({this.ProduitsInfo});

  @override
  State<ProduitsDetailsScreen> createState() => _ProduitsDetailsScreenState();
}

class _ProduitsDetailsScreenState extends State<ProduitsDetailsScreen> 
{
  final currentOnlineUser = Get.put(CurrentUser());
  
  ajouterProduitAuPanier() async
  {
      try
      {
         var res = await http.post(
        Uri.parse(API.ajouterAuPanier),
        body: {
          "user_id": currentOnlineUser.user.username.toString(),
          "produit_id": widget.ProduitsInfo!.item_id.toString(),
          "quantite": 
        },
      );
      }
      catch(errorMsg)
      {
        print("Error :: " + errorMsg.toString());
      }
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //Produits detail image
          FadeInImage(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: const AssetImage("images/PM_utilisateurs.jpg"),
                            image: NetworkImage(
                              widget.ProduitsInfo!.image!,
                            ),
                            imageErrorBuilder: (context, error, stackTraceError)
                            {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                ),
                              );
                            },
                           ),

                    //Informations du produit
                    Align(alignment: Alignment.bottomCenter,
                    child: ProduitsInfoWidget(),
                    ),

        ],
      ),
    );
  }

ProduitsInfoWidget()
{
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
                borderRadius: BorderRadius.circular(30)
              ),
            ),
          ),

           const SizedBox(height: 30,),

           //libelle
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

          //categorie
          //description
          //prix
  
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     
                     //catégorie
                     Text(
                      
                      widget.ProduitsInfo!.categorie!.toString().replaceAll("[", "").replaceAll("]", ""),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                      ),
                      ),
                  
                     const SizedBox(height: 16,),

                        //prix
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

                          //description

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


                             //Ajouter au panier boutton
                       Material(
                        elevation: 4,
                        color: const Color.fromARGB(255, 68, 68, 68),
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: ()
                          {
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
          ],
         )




        ],
      ),
    ),
  );
}
}