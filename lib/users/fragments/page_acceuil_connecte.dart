import 'dart:developer';

import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:ecf_studi2/users/fragments/Mon_compte.dart';
import 'package:ecf_studi2/users/fragments/home_fragment_screen.dart';
import 'package:ecf_studi2/users/fragments/page_contact.dart';
import 'package:ecf_studi2/users/fragments/presentation_ventalis.dart';
import 'package:ecf_studi2/users/fragments/profile_fragment_screen.dart';
import 'package:ecf_studi2/users/panier/ecran_panier_liste.dart';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageConnecte extends StatefulWidget {
  const HomePageConnecte({super.key});

  @override
  State<HomePageConnecte> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageConnecte> {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentUser(),
        initState: (currentstate) {
          log("GEtting user info");
          _rememberCurrentUser.getUserInfo();
        },
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Ventalis", style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(
                  color: Colors.white
                ),
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage('assets/images/NFL_wallpaper.jpg'),
                          )),
                      child: Column(
                        children: [],
                      ),
                    ),
                    ListTile(
                        leading: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.black,
                        ),
                        title: const Text(
                          "Mon Compte",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileFragmentScreen()));
                        }),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_basket,
                        size: 50,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Mon Panier",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PanierListe()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_bag,
                        size: 50,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Catalogue",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeFragmentScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.mail_outlined,
                        size: 50,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Contact",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PageContact()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.factory_sharp,
                        size: 50,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Présentation de l'entreprise",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Presentation()));
                      },
                    ),
                  ],
                ),
              ),
              body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ecologie.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ));
        });
  }
}
