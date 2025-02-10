class SeatModel {
  final int floorId;
  String seatCode;
  int xCor;
  int yCor;
  List<String>? departments;
  DateTime? updated;
  bool isActive;

  SeatModel({
    this.floorId = 0,
    this.seatCode = "",
    this.xCor = 0,
    this.yCor = 0,
    this.departments,
    this.updated,
    this.isActive = true,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      floorId: json['floorId'] as int,
      seatCode: json['seatCode'] as String,
      xCor: json['xCor'] as int,
      yCor: json['yCor'] as int,
      departments: List<String>.from(json['departments'] as List),
      updated: DateTime.parse(json['updated'] as String),
      isActive: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'floorId': floorId,
      'seatCode': seatCode,
      'xCor': xCor,
      'yCor': yCor,
      'departments': departments,
      'updated': updated?.toIso8601String(),
    };
  }
}
