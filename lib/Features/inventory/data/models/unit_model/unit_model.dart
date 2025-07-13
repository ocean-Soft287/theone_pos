class UnitModel {
  final int unitId;
  final String arName;
  final String enName;

  UnitModel({
    required this.unitId,
    required this.arName,
    required this.enName,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      unitId: json['UnitID'],
      arName: json['ArName'],
      enName: json['EnName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UnitID': unitId,
      'ArName': arName,
      'EnName': enName,
    };
  }
}
