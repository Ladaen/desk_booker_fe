class BookingModel {
  String? id;
  String bookingBy;
  String seatCode;
  DateTime bookingDate;
  bool isActive;
  String createdBy;
  DateTime updated;

  BookingModel({
    this.id,
    required this.bookingBy,
    required this.seatCode,
    required this.bookingDate,
    this.isActive = true,
    required this.createdBy,
    required this.updated,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'] as String,
      bookingBy: json['bookingBy'] as String,
      seatCode: json['seatCode'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String,
      updated: DateTime.parse(json['updated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'bookingBy': bookingBy,
      'seatCode': seatCode,
      'bookingDate': bookingDate.toIso8601String(),
      'isActive': isActive,
      'createdBy': createdBy,
      'updated': updated.toIso8601String(),
    };
  }
}