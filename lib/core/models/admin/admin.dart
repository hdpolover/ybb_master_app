class Admin {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;

  Admin(this.id, this.name, this.email, this.password, this.role);

  Admin.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        role = json['role'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      };
}
