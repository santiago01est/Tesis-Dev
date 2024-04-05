import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class UnidadesCubit extends Cubit<List<Unidad>> {
  UnidadesCubit() : super( []);

  void subirUnidades(List<Unidad> unidades){
    emit(unidades);
  }

  void addUnidades(Unidad unidad) {
    emit([...state, unidad]);
}

void eliminarActividadDeUnidad(String idActividad){
 // Recorre cada unidad y busca la actividad para borrarla
  List<Unidad> nuevasUnidades = [];

  for (var unidad in state) {
    // Verifica si la unidad actual tiene la actividad a eliminar
    if (unidad.actividades != null) {
      // for que recorre las actividades
      for (var actividad in unidad.actividades!) {
        if (actividad.id == idActividad) {
          unidad.actividades!.removeWhere((actividad) => actividad.id == idActividad);
        }
      }
      
    }

  nuevasUnidades.add(unidad);
  }

  // Emite la lista actualizada de unidades
  emit(nuevasUnidades);
}



void addActividad(Actividad actividad, String idUnidad) {
   List<Unidad> nuevasUnidades = [];
   for (var unidad in state) {
    if (unidad.id == idUnidad) {
      unidad.actividades!.add(actividad);
    }
    nuevasUnidades.add(unidad);
   }
   emit(nuevasUnidades);


}

  SiguienteActividadInfo siguienteActividadInfo(String idActividad) {
    for (var i = 0; i < state.length; i++) {
      for (var j = 0; j < state[i].actividades!.length; j++) {
        if (state[i].actividades![j].id == idActividad) {
          if (i == state.length - 1 && j == state[i].actividades!.length - 1) {
            return SiguienteActividadInfo('-1', ''); // Última actividad de la última unidad
          } else if (j == state[i].actividades!.length - 1) {
            return SiguienteActividadInfo(state[i + 1].actividades![0].id!, state[i + 1].actividades![0].tipoActividad!); // Primera actividad de la siguiente unidad
          } else {
            return SiguienteActividadInfo(state[i].actividades![j + 1].id!, state[i].actividades![j + 1].tipoActividad!); // Siguiente actividad de la misma unidad
          }
        }
      }
    }
    return SiguienteActividadInfo('', ''); // Si no se encuentra la actividad
  }

  String nombreUnidadDeActividad(String idActividad) {
    for (var unidad in state) {
      for (var actividad in unidad.actividades ?? []) {
        if (actividad.id == idActividad) {
          return unidad.nombre!; // Retorna el nombre de la unidad
        }
      }
    }
    return ''; // Si no se encuentra la actividad
  }

  int? indiceActividadPorId(String idActividad) {

     List<Actividad> todasLasActividades = [];
    for (var i = 0; i < state.length; i++) {
      for (var j = 0; j < state[i].actividades!.length; j++) {
        todasLasActividades.add(state[i].actividades![j]);
      }
    }

    for (var i = 0; i < todasLasActividades.length; i++) {
      if (todasLasActividades[i].id == idActividad) {
        return i; // Devuelve el índice de la actividad en la lista de unidades
      }
    }


    return null; // Si no se encuentra la actividad
  }

 /*
if (state[i].actividades![j].id == idActividad) {
          return j; // Devuelve el índice de la actividad en la lista de unidades
        }
 */

}

class SiguienteActividadInfo {
  final String idActividad;
  final String tipoActividad;

  SiguienteActividadInfo(this.idActividad, this.tipoActividad);
}



