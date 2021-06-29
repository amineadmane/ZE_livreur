class HistoriqueAnnuel {
  int mois;
  int nbLivraisons;
  double distanceTotale;

  HistoriqueAnnuel({this.mois, this.nbLivraisons, this.distanceTotale});

  HistoriqueAnnuel.fromJson(Map<String, dynamic> json) {
    mois = json['mois'];
    nbLivraisons = json['nb_livraisons'];
    distanceTotale = json['distance_totale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mois'] = this.mois;
    data['nb_livraisons'] = this.nbLivraisons;
    data['distance_totale'] = this.distanceTotale;
    return data;
  }
}
