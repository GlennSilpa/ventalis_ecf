import 'package:ecf_studi2/users/fragments/order_fragment_screen.dart';
import 'package:ecf_studi2/users/fragments/page_contact.dart';
import 'package:ecf_studi2/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ecf_studi2/users/fragments/profile_fragment_screen.dart';

class DashboardOfFragments extends StatelessWidget {
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  final List<Widget> _fragmentScreens = [
    OrderFragmentScreen(),
    ProfileFragmentScreen(),
    PageContact(),
  ];

  final List _navigationButtonsProperties = [
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Commandes",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_2_outlined,
      "label": "Profile",
    },
    {
      "active_icon": Icons.chat,
      "non_active_icon": Icons.chat_bubble_outline,
      "label": "Chat",
    },
  ];

  RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentstate) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            key: Key('dashboardOfFragments'),
            child: Obx(
              () => _fragmentScreens[_indexNumber.value],
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              key: Key("bottomNavigationBar"),
              backgroundColor: Colors.black, // Set background color here
              currentIndex: _indexNumber.value,
              onTap: (value) {
                _indexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white24,
              items: List.generate(
                _navigationButtonsProperties.length,
                (index) {
                  var navBtnProperty = _navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
