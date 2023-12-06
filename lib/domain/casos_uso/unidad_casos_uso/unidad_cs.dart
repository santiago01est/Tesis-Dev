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
      Unidad(id: '1', nombre: 'Unidad Uno', estado: 'Activa', actividades: [
        Actividad(
          id: '1',
          nombre: 'Primeros Pasos',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '2',
          nombre: 'Buscando el mejor camino',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '3',
          nombre: 'Diversión en el campo',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '4',
          nombre: 'Adelante, giro, adelante',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '5',
          nombre: 'Hora del café',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
      ]),
      Unidad(id: '2', nombre: 'Unidad Dos', estado: 'Activa', actividades: [
        Actividad(
          id: '6',
          nombre: 'El mejor camino',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '7',
          nombre: 'Recoge las recompensas',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '8',
          nombre: 'Diversión en clase',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '9',
          nombre: 'Si pasa esto hago aquello',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '10',
          nombre: 'Estoy en un ciclo',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
      ]),
      Unidad(id: '3', nombre: 'Unidad Tres', estado: 'Activa', actividades: [
        Actividad(
          id: '11',
          nombre: 'Mi decision',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '12',
          nombre: 'Recoge todas las recompensas',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '13',
          nombre: 'Diversión en clase',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '14',
          nombre: 'Si pasa esto hago aquello',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
        Actividad(
          id: '15',
          nombre: 'Estoy en un ciclo',
          estado: 'Activa',
          descripcion: '',
          tipoActividad: 'Laberinto',
        ),
      ])
    ];
  }
}
