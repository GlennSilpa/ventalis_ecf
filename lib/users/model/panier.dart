class Panier 
{
  int? panier_id;
  int? user_id;
  int? produit_id;
  int? quantite;
  String? libelle;
  String? description;
  double? prix;
  List<String>? categorie;
  String? image;

  Panier({
  this.panier_id,
  this.user_id,
  this.produit_id,
  this.quantite,
  this.libelle,
  this.description,
  this.prix,
  this.categorie,
  this.image,
  });

  factory Panier.fromJson(Map<String, dynamic> json) => Panier(
    panier_id: int.parse(json['panier_id']),
    user_id: int.parse(json['user_id']),
    produit_id: int.parse(json['produit_id']),
    quantite: int.parse(json['quantité']),
    libelle: json['libelle'],
    description: json['description'],
    prix: double.parse(json['prix']),
    categorie: json['categorie'].toString().split(', '),
    image: json['image'],


  );
}