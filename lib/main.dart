import 'package:ecf_studi2/admins/chat_list.dart';
import 'package:ecf_studi2/admins/vendeur_login.dart';
import 'package:ecf_studi2/users/fragments/page_acceuil.dart';
import 'package:ecf_studi2/users/fragments/page_contact.dart';
import 'package:flutter/widgets.dart';
import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'ECF STUDI',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            builder: (context, dataSnapShot) {
              return VendeurLoginScreen();
            },
            future: Future.value()));
  }
}
