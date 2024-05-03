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

  void limpiarCubit(){
    emit([]);
  }

  void actualizarRespuestasActividadesEstudiantes(
      List<int> idsEstudiantes, int numeroRespuesta, int ubicacion) {
    emit(state.map((seguimiento) {
      if (idsEstudiantes.contains(seguimiento.userId)) {
        List<int> nuevasRespuestas =
            List.from(seguimiento.respuestasActividades!);
        if (ubicacion >= 0 && ubicacion < nuevasRespuestas.length) {
          nuevasRespuestas[ubicacion] = numeroRespuesta;
        }
        return seguimiento.copyWith(respuestasActividades: nuevasRespuestas);
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
    final seguimientoEstudiante =
        state.firstWhere((seguimiento) => seguimiento.userId == userId);
    return seguimientoEstudiante;
  }
}
