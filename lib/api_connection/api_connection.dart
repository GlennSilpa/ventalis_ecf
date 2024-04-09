class API {
  static const hostConnect = "https://ventalis1.000webhostapp.com/api_ventalis";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectVendeur = "$hostConnect/vendeur";
  static const hostUploadItem = "$hostConnect/items";
  static const hostProduits = "$hostConnect/produits";
  static const hostPanier = "$hostConnect/panier";
  static const hostOrder = "$hostConnect/orders";

  //signUp-Login user
  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const signUp = "$hostConnectUser/signup.php";
  static const login = "$hostConnectUser/login.php";

  //login vendeur
  static const vendeurLogin = "$hostConnectVendeur/login.php";

  //upload-save items"
  static const uploadNewItem = "$hostUploadItem/upload.php";

//produits
  static const getAllProduits = "$hostProduits/nouveaux.php";

//panier
  static const ajouterAuPanier = "$hostPanier/ajouter.php";
  static const getPanierListe = "$hostPanier/lire.php";

  //order
  static const orderNow = "$hostOrder/order.php";
}
