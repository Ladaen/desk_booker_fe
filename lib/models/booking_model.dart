class BookingModel {
  String bookingBy;
  String seatCode;
  DateTime bookingDate;
  bool isActive;
  String createdBy;
  DateTime updated;

  BookingModel({
    required this.bookingBy,
    required this.seatCode,
    required this.bookingDate,
    this.isActive = true,
    required this.createdBy,
    required this.updated,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
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
      'bookingBy': bookingBy,
      'seatCode': seatCode,
      'bookingDate': bookingDate.toIso8601String(),
      'isActive': isActive,
      'createdBy': createdBy,
      'updated': updated.toIso8601String(),
    };
  }
}