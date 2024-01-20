class NameOne {
  String sn, nitrogen, phosphorus, potassium;
  NameOne(
      {required this.sn,
      required this.nitrogen,
      required this.phosphorus,
      required this.potassium});
  // constructors

  factory NameOne.fromJSON(Map<String, dynamic> json) {
    return NameOne(
      sn: json["sn"],
      nitrogen: json["nitrogen"],
      phosphorus: json["phosphorus"],
      potassium: json["potassium"],
    );
  }
}