class Profesor {
  final int? id;
  final String? nombre;
  final String? email;
  final String? password;
  final String? avatar;
  final String? bio;

  Profesor({
    this.id,
    this.nombre,
    this.email,
    this.password,
    this.avatar,
    this.bio,
  });

  //Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
      'avatar': avatar,
      'bio': bio,
    };
  }
}
