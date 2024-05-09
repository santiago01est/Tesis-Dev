//clase estudiante
class Estudiante {
  int? id;
  String? nombre;
  String? avatar;
  String? genero;

  Estudiante({this.id, this.nombre, this.avatar, this.genero});


factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      id: json['id'],
      nombre: json['nombre'],
      avatar: json['avatar'],
      genero: json['genero'],
    );
  }
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'nombre': nombre,
    'avatar': avatar,
    'genero': genero,
  };
}
}
