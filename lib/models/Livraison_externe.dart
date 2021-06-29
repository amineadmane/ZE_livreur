class LivraisonExterne {
  int idLivraisonExterne;
  int idClient;
  int idColis;
  int idLivreur;
  String nomclient;
  String telephone;
  int wilaya;
  int commune;
  String codePostal;
  String adresse;
  int prix;
  dynamic note;
  String commentaire;
  double ditanceParcourous;
  String createdAt;
  String updatedAt;

  LivraisonExterne(
      {this.idLivraisonExterne,
      this.idClient,
      this.idColis,
      this.idLivreur,
      this.nomclient,
      this.telephone,
      this.wilaya,
      this.commune,
      this.codePostal,
      this.adresse,
      this.prix,
      this.ditanceParcourous,
      this.note,
      this.commentaire,
      this.createdAt,
      this.updatedAt});

  LivraisonExterne.fromJson(Map<String, dynamic> json) {
    idLivraisonExterne = json['id_livraison_externe'];
    idClient = json['id_client'];
    idColis = json['id_colis'];
    idLivreur = json['id_livreur'];
    nomclient = json['nomclient'];
    telephone = json['telephone'];
    wilaya = json['wilaya'];
    commune = json['commune'];
    codePostal = json['codePostal'];
    adresse = json['adresse'];
    prix = json['prix'];
    ditanceParcourous = json['ditance_parcourous'];
    note = json['note'];
    commentaire = json['commentaire'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_livraison_externe'] = this.idLivraisonExterne;
    data['id_client'] = this.idClient;
    data['id_colis'] = this.idColis;
    data['id_livreur'] = this.idLivreur;
    data['nomclient'] = this.nomclient;
    data['telephone'] = this.telephone;
    data['wilaya'] = this.wilaya;
    data['commune'] = this.commune;
    data['codePostal'] = this.codePostal;
    data['adresse'] = this.adresse;
    data['prix'] = this.prix;
    data['ditance_parcourous'] = this.ditanceParcourous;
    data['note'] = this.note;
    data['commentaire'] = this.commentaire;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
