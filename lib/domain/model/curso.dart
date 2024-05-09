import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/unidad.dart';

class Curso {
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
  List<Unidad>? unidades;

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
    this.unidades,
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
      unidades: json['unidades'],
    );
  }

  // Método para asignar valores desde un mapa
  void fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nombre = map['nombre'];
    codigoAcceso = map['codigoAcceso'];
    departamento = map['departamento'];
    ciudad = map['ciudad'];
    colegio = map['colegio'];
    profesor = map['profesor'];
    portada = map['portada'];
    numEstudiantes = map['numEstudiantes'];
    descripcion = map['descripcion'];
    fechaCreacion = map['fechaCreacion'];
    fechaFinalizacion = map['fechaFinalizacion'];
    estado = map['estado'];
    // Convertir la lista de estudiantes si existe
    if (map['estudiantes'] != null) {
      estudiantes = (map['estudiantes'] as List<dynamic>)
          .map((estudiante) => Estudiante.fromJson(estudiante))
          .toList();
    }
    // Convertir la lista de unidades si existe
    if (map['unidades'] != null) {
      unidades = (map['unidades'] as List<dynamic>)
          .map((unidad) => Unidad.fromJson(unidad))
          .toList();
    }
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
      'unidades': unidades,
    };
  }

  @override
  String toString() {
    return 'Curso: $id, $nombre, $codigoAcceso, $departamento, $ciudad, $colegio,$profesor, $portada, $numEstudiantes, $descripcion, $fechaCreacion, $fechaFinalizacion, $estado, $unidades';
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
    'estudiantes': estudiantes?.map((estudiante) => estudiante.toMap()).toList(),
    'unidades': unidades?.map((unidad) => unidad.toMap()).toList(),
  };
}

factory Curso.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot
  ) {
    final data = snapshot.data();
    return Curso(
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
      estudiantes: data?['estudiantes'] is Iterable
          ? List.from(data?['estudiantes'])
          : null,
      unidades: data?['unidades'] is Iterable
          ? List.from(data?['unidades'])
          : null,
    );
  }



  List<Actividad> obtenerTodasActividadesCurso(List<Unidad>? unidades) {
    List<Actividad> todasLasActividades = [];
    for (var i = 0; i < unidades!.length; i++) {
      for (var j = 0; j < unidades[i].actividades!.length; j++) {
        todasLasActividades.add(unidades[i].actividades![j]);
      }
    }

    return todasLasActividades;
  }
}
