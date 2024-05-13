//clase estudiante
class Estudiante {
  int? id;
  String? nombre;
  String? avatar;
  String? genero;

  Estudiante({this.id, this.nombre, this.avatar, this.genero});

// To Map
  factory Estudiante.fromFirestore(Map<String, dynamic> data) {
    return Estudiante(
      id: data['id'],
      nombre: data['nombre'],
      avatar: data['avatar'],
      genero: data['genero'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "avatar": avatar,
      "genero": genero,
    };
  }
}
