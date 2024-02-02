import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:ecf_studi2/users/fragments/home_fragment_screen.dart';
import 'package:ecf_studi2/users/fragments/page_contact.dart';
import 'package:ecf_studi2/users/fragments/presentation_ventalis.dart';
import 'package:ecf_studi2/users/model/produits.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        ListTile(leading: Icon(Icons.login,size: 50,color: Colors.black,), title: Text("Se Connecter",
        style: TextStyle(color:Colors.black,fontSize: 20),),
             contentPadding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30) ),
        onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  LoginScreen()
          ));
       }
        ),


        ListTile(leading: Icon(Icons.sports_football, size: 50,color: Colors.black,), title: Text("Catalogue",
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


        ListTile(leading: Icon(Icons.money_sharp,size: 50,color: Colors.black,), title: Text("Contact",
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

       ListTile(leading: Icon(Icons.money_sharp,size: 50,color: Colors.black,), title: Text("Présentation de l'entreprise",
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