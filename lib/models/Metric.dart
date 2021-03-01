class Metric {
  int idMetric;
  int idLivExt;
  double cATotale;
  double benificeTotale;
  double cAToday;
  double benificeToday;
  double cAMensuel;
  double benificeMensuel;
  double benificeMois1;
  double benificeMois2;
  double benificeMois3;
  double benificeMois4;
  double benificeMois5;

  Metric(
      {this.idMetric,
        this.idLivExt,
        this.cATotale,
        this.benificeTotale,
        this.cAToday,
        this.benificeToday,
        this.cAMensuel,
        this.benificeMensuel,
        this.benificeMois1,
        this.benificeMois2,
        this.benificeMois3,
        this.benificeMois4,
        this.benificeMois5});

  Metric.fromJson(Map<String, dynamic> json) {
    idMetric = json['id_metric'];
    idLivExt = json['id_liv_ext'];
    cATotale = double.parse(json['CA_totale'].toString());
    benificeTotale = double.parse(json['benifice_totale'].toString());
    cAToday = double.parse(json['CA_today'].toString());
    benificeToday = double.parse(json['benifice_today'].toString());
    cAMensuel = double.parse(json['CA_mensuel'].toString());
    benificeMensuel = double.parse(json['benifice_mensuel'].toString());
    benificeMois1 = double.parse(json['benifice_mois_1'].toString());
    benificeMois2 = double.parse(json['benifice_mois_2'].toString());
    benificeMois3 = double.parse(json['benifice_mois_3'].toString());
    benificeMois4 = double.parse(json['benifice_mois_4'].toString());
    benificeMois5 = double.parse(json['benifice_mois_5'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_metric'] = this.idMetric;
    data['id_liv_ext'] = this.idLivExt;
    data['CA_totale'] = this.cATotale;
    data['benifice_totale'] = this.benificeTotale;
    data['CA_today'] = this.cAToday;
    data['benifice_today'] = this.benificeToday;
    data['CA_mensuel'] = this.cAMensuel;
    data['benifice_mensuel'] = this.benificeMensuel;
    data['benifice_mois_1'] = this.benificeMois1;
    data['benifice_mois_2'] = this.benificeMois2;
    data['benifice_mois_3'] = this.benificeMois3;
    data['benifice_mois_4'] = this.benificeMois4;
    data['benifice_mois_5'] = this.benificeMois5;
    return data;
  }
}