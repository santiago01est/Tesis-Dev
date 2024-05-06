import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
class SeguimientoCubit extends Cubit<Seguimiento> {
  SeguimientoCubit() : super(Seguimiento(
          id: 1,
          respuestasActividades: List.generate(80, (index) => -1),
          test: [],
          calificacion: 0));

  // Método para actualizar el profesor
  void actualizarSeguimiento(Seguimiento seguimiento) {
    emit(seguimiento);
  }
}
*/
class SeguimientosEstudiantesCubit extends Cubit<List<Seguimiento>> {
  //TODO: IMPLEMENTAR SEGUIMIENTOS ESTUDIANTES [RECUPERAR DESDE LA BD SEGUN EL CURSOID]
  SeguimientosEstudiantesCubit() : super([]);

  void subirSeguimientos(List<Seguimiento> list) {
    emit(list);
  }

  void limpiarCubit() {
    emit([]);
  }

  void actualizarRespuestasActividadesEstudiantes(
      List<int> idsEstudiantes, String respuesta, int peso, int idActividad) {
    emit(state.map((seguimiento) {
      if (idsEstudiantes.contains(seguimiento.userId)) {
        // Clonar el seguimiento para modificarlo
        final nuevoSeguimiento = seguimiento.copyWith(
          respuestasActividades: seguimiento.respuestasActividades?.map((r) {
            if (r.actividadId == idActividad) {
              // Actualizar la respuesta si la actividad coincide
              return r.copyWith(
                respuestaUsuario: respuesta,
                peso: peso,
              );
            } else {
              return r;
            }
          }).toList(),
        );
        return nuevoSeguimiento;
      } else {
        return seguimiento;
      }
    }).toList());
  }

  void actualizarRespuestasTestEstudiantes(
      List<int> idsEstudiantes, List<int> respuestas) {
    emit(state.map((seguimiento) {
      if (idsEstudiantes.contains(seguimiento.userId)) {
        return seguimiento.copyWith(test: respuestas);
      } else {
        return seguimiento;
      }
    }).toList());
  }

  Seguimiento obtenerSeguimientoEstudiante(int userId) {
    return state.firstWhere((seguimiento) => seguimiento.userId == userId);
  }
}
