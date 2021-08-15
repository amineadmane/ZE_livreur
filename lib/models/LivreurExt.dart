class LivreurExt {
  int idLivExt;
  String nom;
  String eMail;
  String prenom;
  String phoneNumber;
  String idPermis;
  String expireDate;
  String etat;
  String matriculeVehicule;
  String modeleVehicule;
  String couleurVehicule;
  double note;
  int points;
  String codeParrainage;
  String createdAt;
  String updatedAt;
  String typeVehicule;
  dynamic photo;

  LivreurExt(
      {this.idLivExt,
      this.nom,
      this.eMail,
      this.prenom,
      this.phoneNumber,
      this.idPermis,
      this.expireDate,
      this.etat,
      this.matriculeVehicule,
      this.modeleVehicule,
      this.couleurVehicule,
      this.note,
      this.points,
      this.codeParrainage,
      this.createdAt,
      this.updatedAt,
      this.photo});

  LivreurExt.fromJson(Map<String, dynamic> json) {
    idLivExt = json['id_liv_ext'];
    nom = json['nom'];
    eMail = json['e_mail'];
    prenom = json['prenom'];
    phoneNumber = json['phone_number'];
    idPermis = json['id_permis'];
    expireDate = json['expire_date'];
    etat = json['etat'];
    matriculeVehicule = json['matricule_vehicule'];
    modeleVehicule = json['modele_vehicule'];
    couleurVehicule = json['couleur_vehicule'];
    note = json['note'].toDouble();
    points = json['points'];
    codeParrainage = json['code_parrainage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_liv_ext'] = this.idLivExt;
    data['nom'] = this.nom;
    data['e_mail'] = this.eMail;
    data['prenom'] = this.prenom;
    data['phone_number'] = this.phoneNumber;
    data['id_permis'] = this.idPermis;
    data['expire_date'] = this.expireDate;
    data['etat'] = this.etat;
    data['matricule_vehicule'] = this.matriculeVehicule;
    data['modele_vehicule'] = this.modeleVehicule;
    data['couleur_vehicule'] = this.couleurVehicule;
    data['note'] = this.note;
    data['points'] = this.points;
    data['code_parrainage'] = this.codeParrainage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo'] = (this.photo);
    return data;
  }
}
