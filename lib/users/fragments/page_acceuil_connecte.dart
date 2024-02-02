import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:ecf_studi2/users/fragments/Mon_compte.dart';
import 'package:ecf_studi2/users/fragments/home_fragment_screen.dart';
import 'package:ecf_studi2/users/fragments/page_contact.dart';
import 'package:ecf_studi2/users/fragments/presentation_ventalis.dart';
import 'package:ecf_studi2/users/model/produits.dart';
import 'package:ecf_studi2/users/panier/ecran_panier_liste.dart';
import 'package:flutter/material.dart';

class HomePageConnecte extends StatefulWidget {
  const HomePageConnecte({super.key});

  @override
  State<HomePageConnecte> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageConnecte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text("Ventalis"),
      backgroundColor: Colors.black,
    ),
    drawer: Drawer(
      child: ListView(children: [ 
        DrawerHeader (decoration:BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.fill, 
            image: AssetImage('assets/images/NFL_wallpaper.jpg'),
            )
        ), child: Column(
          children: [
            
              
          ],
        ),),
        ListTile(leading: Icon(Icons.person, size: 50,color: Colors.black,), title: Text("Mon Compte",
        style: TextStyle(color:Colors.black,fontSize: 20),),
             contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30) ),
        onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  MonCompte()
          ));
       }
        ),

        ListTile(leading: Icon(Icons.shopping_basket, size : 50,color: Colors.black,), title: Text("Mon Panier",
        style: TextStyle(color:Colors.black,fontSize: 20),
        ),
        contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30) ),
        onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  LoginScreen()
          ));
       },),


        ListTile(leading: Icon(Icons.shopping_bag, size: 50,color: Colors.black,), title: Text("Catalogue",
        style: TextStyle(color:Colors.black,fontSize: 20),
        ),
        contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30) ),
       onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  HomeFragmentScreen()
          ));
       },),


        ListTile(leading: Icon(Icons.mail_outlined,size: 50,color: Colors.black,), title: Text("Contact",
        style: TextStyle(color:Colors.black,fontSize: 20),
        ),
        contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30) ),
        onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  PageContact()
          ));
       },),

       ListTile(leading: Icon(Icons.factory_sharp, size: 50,color: Colors.black,), title: Text("Présentation de l'entreprise",
        style: TextStyle(color:Colors.black,fontSize: 20),
        ),
        contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30) ),
        onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  Presentation()
          ));
       },),



      ],),
    ),
    body: Container(alignment: Alignment.center,
    padding: const EdgeInsets.all(32),
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(
        'assets/images/NFL_field.jpg'),
        fit: BoxFit.cover,
        ),
    ),
    
    )
      
          
         
      
    


    
    
      


    
    );
  }
}