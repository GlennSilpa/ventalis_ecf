class API
{
  static const hostConnect = "http://192.168.1.11/api_ventalis";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectVendeur = "$hostConnect/vendeur";

  //signUp user
  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const signUp = "$hostConnectUser/signup.php";
  static const login = "$hostConnectUser/login.php";


  //login vendeur
static const vendeurLogin = "$hostConnectVendeur/login.php";

}