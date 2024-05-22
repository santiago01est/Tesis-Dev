import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
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

  void actualizarCalificacionActiviidadSeguimiento(
      int userId, int actividadId, int nuevaCalificacion, int cursoId) {
    emit(state.map((seguimiento) {
      if (seguimiento.userId == userId && seguimiento.cursoId == cursoId) {
        // Buscar la respuesta correspondiente a la actividad
        final nuevasRespuestasActividades =
            seguimiento.respuestasActividades?.map((r) {
          if (r.actividadId == actividadId) {
            // Actualizar la calificación de la respuesta
            return r.copyWith(
              peso: nuevaCalificacion,
            );
          } else {
            return r;
          }
        }).toList();
        // Clonar el seguimiento para actualizar las respuestas
        return seguimiento.copyWith(
          respuestasActividades: nuevasRespuestasActividades,
        );
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

  // Agregar una respuesta a la lista en cada seguimiento
  void agregarRespuesta(int cursoId, Actividad actividad) {
    emit(state.map((seguimiento) {
      if (seguimiento.cursoId == cursoId) {
        // Inicializar la lista si es nula
        seguimiento.respuestasActividades ??= [];
        Respuesta nuevaRespuesta = Respuesta(
            id: 1,
            respuestaUsuario: '',
            peso: -1,
            actividadId: actividad.id!,
            seguimientoId: seguimiento.id);
        // Añadir la nueva respuesta a la lista
        seguimiento.respuestasActividades!.add(nuevaRespuesta);
      }
      return seguimiento;
    }).toList());
  }

  void eliminarActividadDeUnidadDelCurso(int idActividad) {
    emit(state.map((seguimiento) {
      seguimiento.respuestasActividades
          ?.removeWhere((element) => element.actividadId == idActividad);
      return seguimiento;
    }).toList());
    
  }
}
