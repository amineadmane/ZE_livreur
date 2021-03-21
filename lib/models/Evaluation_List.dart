class Evaluation_List {
  var note;
  String commentaire;
  String createdAt;
  String nom;
  String prenom;

  Evaluation_List(
      {this.note, this.commentaire, this.createdAt, this.nom, this.prenom});

  Evaluation_List.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    commentaire = json['commentaire'];
    createdAt = json['created_at'];
    nom = json['nom'];
    prenom = json['prenom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['commentaire'] = this.commentaire;
    data['created_at'] = this.createdAt;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    return data;
  }
}