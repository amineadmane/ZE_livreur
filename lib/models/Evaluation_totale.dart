class EvaluationTotale {
  double note;

  EvaluationTotale({this.note});

  EvaluationTotale.fromJson(Map<String, dynamic> json) {
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    return data;
  }
}
