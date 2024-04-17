import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:ecf_studi2/users/fragments/home_fragment_screen.dart';
import 'package:ecf_studi2/users/fragments/page_contact.dart';
import 'package:ecf_studi2/users/fragments/presentation_ventalis.dart';
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
          title: const Text("Ventalis"),
          backgroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/NFL_wallpaper.jpg'),
                    )),
                child: Column(
                  children: [],
                ),
              ),
              ListTile(
                  leading: const Icon(
                    Icons.login,
                    size: 50,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Se Connecter",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  }),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PageContact()));
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
          // height: 400,
          // width: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ecologie.webp'),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
