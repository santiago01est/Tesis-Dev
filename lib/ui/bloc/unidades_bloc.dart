import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class UnidadesCubit extends Cubit<List<Unidad>> {
  UnidadesCubit() : super([]);

  void subirUnidades(List<Unidad> unidades) {
    emit(unidades);
  }

  void limpiarCubit() {
    emit([]);
  }

  void addUnidades(Unidad unidad) {
    emit([...state, unidad]);
  }

  void eliminarActividadDeUnidad(int idActividad) {
    // Recorre cada unidad y busca la actividad para borrarla
    List<Unidad> nuevasUnidades = [];

    for (var unidad in state) {
      // Verifica si la unidad actual tiene la actividad a eliminar
      if (unidad.actividades != null) {
        // for que recorre las actividades
        for (var actividad in unidad.actividades!) {
          if (actividad.id == idActividad) {
            unidad.actividades!
                .removeWhere((actividad) => actividad.id == idActividad);
          }
        }
      }

      nuevasUnidades.add(unidad);
    }

    // Emite la lista actualizada de unidades
    emit(nuevasUnidades);
  }

  // obtener unidad por id
  Unidad? obtenerUnidadPorId(int id) {
    for (var unidad in state) {
      if (unidad.id == id) {
        return unidad;
      }
    }
    return null;
  }

  void addActividad(Actividad actividad, int idUnidad) {
    List<Unidad> nuevasUnidades = [];
    for (var unidad in state) {
      if (unidad.id == idUnidad) {
        unidad.actividades!.add(actividad);
        // reordenar indices de las actividades
        ordenarIndices();
      }
      nuevasUnidades.add(unidad);
    }
    emit(nuevasUnidades);
  }

  void ordenarIndices() {
    // Recorre cada unidad y reordena los índices de las actividades
    List<Unidad> ordenUnidades = [];
    for (var unidad in state) {
      if (unidad.actividades != null) {
        for (int i = 0; i < unidad.actividades!.length; i) {
          unidad.actividades![i].indice = i+1;
        }
        ordenUnidades.add(unidad);
      }
    }
    emit(ordenUnidades);
  }

  SiguienteActividadInfo siguienteActividadInfo(int idActividad) {
    for (var i = 0; i < state.length; i++) {
      for (var j = 0; j < state[i].actividades!.length; j++) {
        if (state[i].actividades![j].id == idActividad) {
          if (i == state.length - 1 && j == state[i].actividades!.length - 1) {
            return SiguienteActividadInfo(
                -1, ''); // Última actividad de la última unidad
          } else if (j == state[i].actividades!.length - 1) {
            return SiguienteActividadInfo(
                state[i + 1].actividades![0].id!,
                state[i + 1]
                    .actividades![0]
                    .tipoActividad!); // Primera actividad de la siguiente unidad
          } else {
            return SiguienteActividadInfo(
                state[i].actividades![j + 1].id!,
                state[i]
                    .actividades![j + 1]
                    .tipoActividad!); // Siguiente actividad de la misma unidad
          }
        }
      }
    }
    return SiguienteActividadInfo(1, ''); // Si no se encuentra la actividad
  }

  String nombreUnidadDeActividad(int idActividad) {
    for (var unidad in state) {
      for (var actividad in unidad.actividades ?? []) {
        if (actividad.id == idActividad) {
          return unidad.nombre!; // Retorna el nombre de la unidad
        }
      }
    }
    return ''; // Si no se encuentra la actividad
  }

  int? indiceActividadPorId(int idActividad) {
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

// indice global en el curso entre todas las actividades
  Actividad? actividadPorId(int idActividad) {
    List<Actividad> todasLasActividades = [];
    for (var i = 0; i < state.length; i++) {
      for (var j = 0; j < state[i].actividades!.length; j++) {
        todasLasActividades.add(state[i].actividades![j]);
      }
    }

    for (var i = 0; i < todasLasActividades.length; i++) {
      if (todasLasActividades[i].id == idActividad) {
        return todasLasActividades[i];

        // Devuelve el índice de la actividad en la lista de unidades
      }
    }

    return null; // Si no se encuentra la actividad
  }

  int? obtenerIndiceActividadEnUnidad(int idActividad) {
    for (int i = 0; i < state.length; i++) {
      if (state[i].actividades != null) {
        for (int j = 0; j < state[i].actividades!.length; j++) {
          if (state[i].actividades![j].id == idActividad) {
            return j; // Devuelve el índice de la actividad dentro de la unidad
          }
        }
      }
    }
    return null; // Retorna null si no se encuentra la actividad en ninguna unidad
  }

  bool esUltimaActividadGlobal(int idActividad) {
    int? indiceActividad = indiceActividadPorId(idActividad);
    if (indiceActividad != null) {
      List<Actividad> todasLasActividades = [];
      for (var i = 0; i < state.length; i++) {
        for (var j = 0; j < state[i].actividades!.length; j++) {
          todasLasActividades.add(state[i].actividades![j]);
        }
      }
      // Comprueba si el índice de la actividad es igual al número total de actividades menos 1
      return indiceActividad == todasLasActividades.length - 1;
    }
    // Si no se encuentra la actividad, no puede ser la última
    return false;
  }
}

class SiguienteActividadInfo {
  final int idActividad;
  final String tipoActividad;

  SiguienteActividadInfo(this.idActividad, this.tipoActividad);
}
