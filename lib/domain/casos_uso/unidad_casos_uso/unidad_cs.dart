import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/domain/repository/unidad_repository.dart';

class UnidadCasoUso {
  final UnidadRepository unidadRepository;
  UnidadCasoUso(this.unidadRepository);

  Future<List<Unidad>> getUnidades(String idCurso) {
    return unidadRepository.getUnidades(idCurso);
  }

  int numeroTotalActividades(Curso curso) {
    // cuenta el numero total de actividades que tiene cada unidad de listaUnidades
    int numeroTotalActividades = 0;
    for (int i = 0; i < curso.unidades!.length; i++) {
      for (int j = 0; j < curso.unidades![i].actividades!.length; j++) {
        numeroTotalActividades++;
      }
    }
    return numeroTotalActividades;
  }

  /* Ambiente pruebas */

  //metodo para obtener todas las unidades datos quemados
  List<Unidad> getUnidadesPrueba() {
    return [
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
    ];
  }
}
