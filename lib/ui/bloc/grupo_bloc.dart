import 'package:dev_tesis/domain/model/grupo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GrupoEstudiantesCubit extends Cubit<List<Grupo>> {
  GrupoEstudiantesCubit() : super([]);

  void actualizarGrupos(List<Grupo> grupos) {
    emit(grupos);
  }

  void agregarGrupo(Grupo nuevoGrupo) {
    List<Grupo> grupos = List.from(state); // Crea una nueva lista
    grupos.add(nuevoGrupo);
    emit(grupos);
  }
}
