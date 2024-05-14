import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';

class CursoFirebase {
  int? id;
  String? nombre;
  String? codigoAcceso;
  String? departamento;
  String? ciudad;
  String? colegio;
  int? profesor;
  String? portada;
  int? numEstudiantes;
  String? descripcion;
  String? fechaCreacion;
  String? fechaFinalizacion;
  bool? estado;
  List<Estudiante>? estudiantes;

  CursoFirebase({
    this.id,
    this.nombre,
    this.codigoAcceso,
    this.departamento,
    this.ciudad,
    this.colegio,
    this.profesor,
    this.portada,
    this.numEstudiantes,
    this.descripcion,
    this.fechaCreacion,
    this.fechaFinalizacion,
    this.estado,
    this.estudiantes,
  });

  @override
  String toString() {
    return 'Curso: $id, $nombre, $codigoAcceso, $departamento, $ciudad, $colegio,$profesor, $portada, $numEstudiantes, $descripcion, $fechaCreacion, $fechaFinalizacion, $estado';
  }

  factory CursoFirebase.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return CursoFirebase(
      id: data?['id'],
      nombre: data?['nombre'],
      codigoAcceso: data?['codigoAcceso'],
      departamento: data?['departamento'],
      ciudad: data?['ciudad'],
      colegio: data?['colegio'],
      profesor: data?['profesor'],
      portada: data?['portada'],
      numEstudiantes: data?['numEstudiantes'],
      descripcion: data?['descripcion'],
      fechaCreacion: data?['fechaCreacion'],
      fechaFinalizacion: data?['fechaFinalizacion'],
      estado: data?['estado'],
      estudiantes: (data?['estudiantes'] as List<dynamic>?)
          ?.map((estudianteData) => Estudiante.fromFirestore(estudianteData))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (nombre != null) "nombre": nombre,
      if (codigoAcceso != null) "codigoAcceso": codigoAcceso,
      if (departamento != null) "departamento": departamento,
      if (ciudad != null) "ciudad": ciudad,
      if (colegio != null) "colegio": colegio,
      if (profesor != null) "profesor": profesor,
      if (portada != null) "portada": portada,
      if (numEstudiantes != null) "numEstudiantes": numEstudiantes,
      if (descripcion != null) "descripcion": descripcion,
      if (fechaCreacion != null) "fechaCreacion": fechaCreacion,
      if (fechaFinalizacion != null) "fechaFinalizacion": fechaFinalizacion,
      if (estado != null) "estado": estado,
      if (estudiantes != null)
        "estudiantes":
            estudiantes?.map((estudiante) => estudiante.toFirestore()).toList(),
    };
  }
}