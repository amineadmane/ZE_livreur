class HistoMensuel {
  int idlivext;
  String clientname;
  String clientprenom;
  String datelivraison;
  String dropoff;
  String pickup;
  int note;
  int prix;

  HistoMensuel(
      {this.idlivext,
      this.clientname,
      this.clientprenom,
      this.datelivraison,
      this.dropoff,
      this.pickup,
      this.note});

  HistoMensuel.fromJson(Map<String, dynamic> json) {
    idlivext = json['idlivext'];
    clientname = json['clientname'];
    clientprenom = json['clientprenom'];
    datelivraison = json['datelivraison'];
    dropoff = json['dropoff'];
    pickup = json['pickup'];
    note = json['note'];
    prix = json['prix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idlivext'] = this.idlivext;
    data['clientname'] = this.clientname;
    data['clientprenom'] = this.clientprenom;
    data['datelivraison'] = this.datelivraison;
    data['dropoff'] = this.dropoff;
    data['pickup'] = this.pickup;
    data['note'] = this.note;
    data['prix'] = this.prix;
    return data;
  }
}
