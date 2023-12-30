import 'package:get/get.dart';
import 'package:ecf_studi2/users/model/user.dart';
import 'package:ecf_studi2/users/userPreferences/user_preference.dart';

class CurrentUser extends GetxController
{
  Rx<User> _currentUser = User(0,'','','','','').obs;

  User get user => _currentUser.value;

  getUserInfo() async
  {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}