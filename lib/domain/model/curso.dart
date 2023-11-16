class Curso {
  String id;
  String nombre;
  String codigoAcceso;
  String departamento;
  String ciudad;
  String colegio;
  String profesor;
  String portada;
  int numEstudiantes;
  String descripcion;
  String fechaCreacion;
  String fechaFinalizacion;
  String estado;

  Curso({
    required this.id,
    required this.nombre,
    required this.codigoAcceso,
    required this.departamento,
    required this.ciudad,
    required this.colegio,
    required this.profesor,
    required this.portada,
    required this.numEstudiantes,
    required this.descripcion,
    required this.fechaCreacion,
    required this.fechaFinalizacion,
    required this.estado,
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
    };
  }
}
