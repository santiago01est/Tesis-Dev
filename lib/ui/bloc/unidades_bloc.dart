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

}
