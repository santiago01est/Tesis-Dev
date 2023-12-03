import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';

class CursosDataAdapter extends CursoRepository {
  @override
  Future<List<Curso>> getCursos() {
    /* TODO: implement getCursos BD mientras sera por mapas */
    Curso c1 = Curso(
      id: '1',
      nombre: 'Curso 1',
      codigoAcceso: '12345',
      departamento: 'Departamento 1',
      ciudad: 'Ciudad 1',
      colegio: 'Colegio 1',
      profesor: 'Profesor 1',
      portada: 'assets/Inicio.png',
      estado: 'Activo',
      numEstudiantes: 10,
      descripcion: "Descripción 1",
      fechaCreacion: '2022-01-01',
      fechaFinalizacion: '2022-01-01',
    );
    Curso c2 = Curso(
      id: '2',
      nombre: 'Curso 2',
      codigoAcceso: '12345',
      departamento: 'Departamento 2',
      ciudad: 'Ciudad 2',
      colegio: 'Colegio 2',
      profesor: 'Profesor 2',
      portada: 'assets/Inicio.png',
      estado: 'Activo',
      numEstudiantes: 10,
      descripcion: "Descripción 2",
      fechaCreacion: '2022-01-01',
      fechaFinalizacion: '2022-01-01',
    );
    Curso c3 = Curso(
      id: '3',
      nombre: 'Curso 3',
      codigoAcceso: '12345',
      departamento: 'Departamento 3',
      ciudad: 'Ciudad 3',
      colegio: 'Colegio 3',
      profesor: 'Profesor 3',
      portada: 'assets/Inicio.png',
      estado: 'Activo',
      numEstudiantes: 10,
      descripcion: "Descripción 3",
      fechaCreacion: '2022-01-01',
      fechaFinalizacion: '2022-01-01',
    );
    Curso c4 = Curso(
      id: '4',
      nombre: 'Curso 4',
      codigoAcceso: '12345',
      departamento: 'Departamento 4',
      ciudad: 'Ciudad 4',
      colegio: 'Colegio 4',
      profesor: 'Profesor 4',
      portada: 'assets/Inicio.png',
      estado: 'Activo',
      numEstudiantes: 10,
      descripcion: "Descripción 4",
      fechaCreacion: '2022-01-01',
      fechaFinalizacion: '2022-01-01',
    );
    Curso c5 = Curso(
      id: '5',
      nombre: 'Curso 5',
      codigoAcceso: '12345',
      departamento: 'Departamento 5',
      ciudad: 'Ciudad 5',
      colegio: 'Colegio 5',
      profesor: 'Angela Maria Muñoz Muñoz',
      portada: 'assets/Inicio.png',
      estado: 'Activo',
      numEstudiantes: 10,
      descripcion:
          "Descripción una muy larga descripcionnnn muy larga muy larga",
      fechaCreacion: '2022-01-01',
      fechaFinalizacion: '2022-01-01',
    );
    List<Curso> cursos = [c1, c2, c3, c4, c5];
    return Future.value(cursos);
  }

  @override
  void guardarCurso(Curso curso) {
    // TODO: implement guardarCurso
  }
}
