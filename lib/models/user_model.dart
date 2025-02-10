class UserModel {
  final String? name;
  final String? email;
  final String? role;
  final String? department;
  final String? password;

  UserModel({
    this.name,
    this.email,
    this.role,
    this.department,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      department: json['department'],
      password: json['password'],
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
