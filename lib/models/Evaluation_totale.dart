class Evaluation_totale {
  double note;

  Evaluation_totale({this.note});

  Evaluation_totale.fromJson(Map<String, dynamic> json) {
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    return data;
  }
}