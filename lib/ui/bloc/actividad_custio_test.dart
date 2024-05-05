import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class ActividadCuestionarioCubit extends Cubit<List<ActividadCuestionario>> {
  ActividadCuestionarioCubit() : super([]);

  void addActividadCuestionario(ActividadCuestionario actividadCuestionario) {
    emit([...state, actividadCuestionario]);
  }
}
