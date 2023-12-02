import 'package:dev_tesis/domain/model/estudiante.dart';

class Curso {
  String? id;
  String? nombre;
  String? codigoAcceso;
  String? departamento;
  String? ciudad;
  String? colegio;
  String? profesor;
  String? portada;
  int? numEstudiantes;
  String? descripcion;
  String? fechaCreacion;
  String? fechaFinalizacion;
  String? estado;
  List<Estudiante>? estudiantes;

  Curso({
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

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      nombre: json['nombre'],
      codigoAcceso: json['codigoAcceso'],
      departamento: json['departamento'],
      ciudad: json['ciudad'],
      colegio: json['colegio'],
      profesor: json['profesor'],
      portada: json['portada'],
      numEstudiantes: json['numEstudiantes'],
      descripcion: json['descripcion'],
      fechaCreacion: json['fechaCreacion'],
      fechaFinalizacion: json['fechaFinalizacion'],
      estado: json['estado'],
      estudiantes: json['estudiantes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'codigoAcceso': codigoAcceso,
      'departamento': departamento,
      'ciudad': ciudad,
      'colegio': colegio,
      'profesor': profesor,
      'portada': portada,
      'numEstudiantes': numEstudiantes,
      'descripcion': descripcion,
      'fechaCreacion': fechaCreacion,
      'fechaFinalizacion': fechaFinalizacion,
      'estado': estado,
      'estudiantes': estudiantes,
    };
  }

  @override
  String toString() {
    return 'Curso: $id, $nombre, $codigoAcceso, $departamento, $ciudad, $colegio,$profesor, $portada, $numEstudiantes, $descripcion, $fechaCreacion, $fechaFinalizacion, $estado';
  }

  //metodo toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'codigoAcceso': codigoAcceso,
      'departamento': departamento,
      'ciudad': ciudad,
      'colegio': colegio,
      'profesor': profesor,
      'portada': portada,
      'numEstudiantes': numEstudiantes,
      'descripcion': descripcion,
      'fechaCreacion': fechaCreacion,
      'fechaFinalizacion': fechaFinalizacion,
      'estado': estado,
      'estudiantes': estudiantes,
    };
  }
}
