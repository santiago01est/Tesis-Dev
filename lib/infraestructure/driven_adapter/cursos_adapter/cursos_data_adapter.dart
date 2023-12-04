import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';

class CursosDataAdapter extends CursoRepository {
  @override
  Future<List<Curso>> getCursos() {
    /* TODO: implement getCursos BD mientras sera por mapas */
    Curso c1 = Curso(
      id: '1',
      nombre: 'Curso Quinto C',
      codigoAcceso: '12345',
      departamento: 'Quindío',
      ciudad: 'Calarca',
      colegio: 'IE General Santander',
      profesor: 'Angela Maria Muñoz Muñoz',
      portada: 'assets/Inicio.png',
      estado: true,
      numEstudiantes: 10,
      descripcion:
          "Este es un espacio para el desarrollo y evaluacion del pensamiento computacional. Donde puedes aprender y divertirte.",
      fechaCreacion: '2022-01-01',
      fechaFinalizacion: '2022-01-01',
      unidades: [
        Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
          Actividad(
            id: '1',
            nombre: 'Actividad 1',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '2',
            nombre: 'Actividad 2',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '3',
            nombre: 'Actividad 3',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '4',
            nombre: 'Actividad 4',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '5',
            nombre: 'Actividad 5',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
        ]),
        Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
          Actividad(
            id: '6',
            nombre: 'Actividad 6',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '7',
            nombre: 'Actividad 7',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '8',
            nombre: 'Actividad 8',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '9',
            nombre: 'Actividad 9',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
          Actividad(
            id: '10',
            nombre: 'Actividad 10',
            estado: 'Activa',
            descripcion: '',
            tipoActividad: 'Laberinto',
          ),
        ])
      ],
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
        estado: true,
        numEstudiantes: 10,
        descripcion: "Descripción 2",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ]);
    Curso c3 = Curso(
        id: '3',
        nombre: 'Curso 3',
        codigoAcceso: '12345',
        departamento: 'Departamento 3',
        ciudad: 'Ciudad 3',
        colegio: 'Colegio 3',
        profesor: 'Profesor 3',
        portada: 'assets/Inicio.png',
        estado: true,
        numEstudiantes: 10,
        descripcion: "Descripción 3",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ]);
    Curso c4 = Curso(
        id: '4',
        nombre: 'Curso 4',
        codigoAcceso: '12345',
        departamento: 'Departamento 4',
        ciudad: 'Ciudad 4',
        colegio: 'Colegio 4',
        profesor: 'Profesor 4',
        portada: 'assets/Inicio.png',
        estado: true,
        numEstudiantes: 10,
        descripcion: "Descripción 4",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ]);
    Curso c5 = Curso(
        id: '5',
        nombre: 'Curso 5',
        codigoAcceso: '12345',
        departamento: 'Departamento 5',
        ciudad: 'Ciudad 5',
        colegio: 'Colegio 5',
        profesor: 'Angela Maria Muñoz Muñoz',
        portada: 'assets/Inicio.png',
        estado: true,
        numEstudiantes: 10,
        descripcion:
            "Descripción una muy larga descripcionnnn muy larga muy larga",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ]);
    List<Curso> cursos = [c1, c2, c3, c4, c5];
    return Future.value(cursos);
  }

  @override
  void guardarCurso(Curso curso) {
    // TODO: implement guardarCurso
  }

  @override
  Future<Curso> getCursoById(String id) {
    // TODO: implement getCursoById
    throw UnimplementedError();
  }
}
