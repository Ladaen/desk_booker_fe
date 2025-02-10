
class FloorModel {
  final int id;
  final String floor;
  final String floorPlanPath;
  final DateTime floorPlanLastModified;
  final List<String> departments;
  final DateTime updated;

  FloorModel({
    required this.id,
    required this.floor,
    required this.floorPlanPath,
    required this.floorPlanLastModified,
    required this.departments,
    required this.updated,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) {
    return FloorModel(
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