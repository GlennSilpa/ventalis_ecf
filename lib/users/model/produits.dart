import 'package:flutter/widgets.dart';

class Produits 
{
 int? item_id;
 String? libelle;
 String? description;
 double? prix; 
 List<String>? categorie;
 String? image;

 Produits({
  this.item_id,
  this.libelle,
  this.description,
  this.prix,
  this.categorie,
  this.image,
  });

  factory Produits.fromJson(Map<String, dynamic> json) => Produits(
    item_id: int.parse(json["itam_id"]),
    libelle: json["libelle"],
    description: json["description"],
    prix: double.parse(json["prix"]),
    categorie: json["categorie"].toString().split(", "),
    image: json['image'],
  );
}