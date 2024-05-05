import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class BDemoMundoPC extends Cubit<List<Seguimiento>> {
  BDemoMundoPC() : super([]);

  // Método para cambiar el nombre
  void subirSeguimientos(List<Actividad> actividades) {
    emit([
      Seguimiento(
          id: 1,
          respuestasActividades: List.generate(
              actividades.length,
              (index) => Respuesta(
                  id: 1,
                  respuestaUsuario: '',
                  peso: -1,
                  actividadId: actividades[index].id!)),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 1,
          cursoId: 1),
      Seguimiento(
          id: 2,
          respuestasActividades: List.generate(
              actividades.length,
              (index) => Respuesta(
                  id: 2,
                  respuestaUsuario: '',
                  peso: -1,
                  actividadId: actividades[index].id!)),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 2,
          cursoId: 1)
    ]);
  }

  void limpiarCubit() {
    emit([]);
  }

  //obtener una lista de seguimiento dado el id de un curso
  List<Seguimiento> obtenerSeguimiento(int idCurso) {
    List<Seguimiento> seguimientos = List.from(state);
    return seguimientos
        .where((seguimiento) => seguimiento.cursoId == idCurso)
        .toList();
  }

  // Método para agregar un seguimiento a la lista actual
  void agregarSeguimiento(Seguimiento nuevoSeguimiento) {
    List<Seguimiento> seguimientos = List.from(state); // Crea una nueva lista
    seguimientos.add(nuevoSeguimiento);
    emit(seguimientos);
  }

  // Metodo que une una lista de seguimientos con la actual
  void unirSeguimientos(List<Seguimiento> nuevosSeguimientos) {
    List<Seguimiento> seguimientos = List.from(state); // Crea una nueva lista
    seguimientos.addAll(nuevosSeguimientos);
    emit(seguimientos);
  }
}
