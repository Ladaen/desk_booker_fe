class Booking {
  String bookingBy;
  String seatCode;
  DateTime bookingDate;
  bool isActive;
  String createdBy;
  DateTime updated;

  Booking({
    required this.bookingBy,
    required this.seatCode,
    required this.bookingDate,
    this.isActive = true,
    required this.createdBy,
    required this.updated,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
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

class User {
  final String name;
  final String email;
  final String role;
  final String department;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      department: json['department'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'password': password,
    };
  }
}

class Seat {
  final int floorId;
  final String seatCode;
  final double xCor;
  final double yCor;
  final List<String> departments;
  final DateTime updated;

  Seat({
    required this.floorId,
    required this.seatCode,
    required this.xCor,
    required this.yCor,
    required this.departments,
    required this.updated,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      floorId: json['floorId'] as int,
      seatCode: json['seatCode'] as String,
      xCor: json['xCor'] as double,
      yCor: json['yCor'] as double,
      departments: List<String>.from(json['departments'] as List),
      updated: DateTime.parse(json['updated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'floorId': floorId,
      'seatCode': seatCode,
      'xCor': xCor,
      'yCor': yCor,
      'departments': departments,
      'updated': updated.toIso8601String(),
    };
  }
}

class Floor {
  final int id;
  final String floor;
  final String floorPlanPath;
  final DateTime floorPlanLastModified;
  final List<String> departments;
  final DateTime updated;

  Floor({
    required this.id,
    required this.floor,
    required this.floorPlanPath,
    required this.floorPlanLastModified,
    required this.departments,
    required this.updated,
  });

  factory Floor.fromJson(Map<String, dynamic> json) {
    return Floor(
      id: json['id'] as int,
      floor: json['floor'] as String,
      floorPlanPath: json['floorPlanPath'] as String,
      floorPlanLastModified: DateTime.parse(json['floorPlanLastModified'] as String),
      departments: List<String>.from(json['departments'] as List),
      updated: DateTime.parse(json['updated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'floor': floor,
      'floorPlanPath': floorPlanPath,
      'floorPlanLastModified': floorPlanLastModified.toIso8601String(),
      'departments': departments,
      'updated': updated.toIso8601String(),
    };
  }
}

