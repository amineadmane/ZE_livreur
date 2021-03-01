class Parrainagemodel {
  String codeParrainage;
  int points;

  Parrainagemodel({this.codeParrainage, this.points});

  Parrainagemodel.fromJson(Map<String, dynamic> json) {
    codeParrainage = json['code_parrainage'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_parrainage'] = this.codeParrainage;
    data['points'] = this.points;
    return data;
  }
}