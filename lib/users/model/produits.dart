import 'package:flutter/widgets.dart';

class Produits {
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

  factory Produits.fromJson(Map<String, dynamic> json) {
    return Produits(
      item_id: json["item_id"] != null ? int.tryParse(json["item_id"].toString()) : null,
      libelle: json["libelle"] ?? '',
      description: json["description"] ?? '',
      prix: json["prix"] != null ? double.tryParse(json["prix"].toString()) : null,
      categorie: json["categorie"]?.toString().split(", ") ?? [],
      image: json['image'] ?? '',
    );
  }
}