import 'package:cloud_firestore/cloud_firestore.dart';

class Profesor {
  int? id;
  String? nombre;
  String? email;
  String? password;
  String? avatar;
  String? bio;

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

  void fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nombre = data['nombre'];
    email = data['email'];
    password = data['password'];
    avatar = data['avatar'];
    bio = data['bio'];
  }

  factory Profesor.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Profesor(
      id: data?['id'],
      nombre: data?['nombre'],
      email: data?['email'],
      password: data?['password'],
      avatar: data?['avatar'],
      bio: data?['bio'],
    );
  }
}
