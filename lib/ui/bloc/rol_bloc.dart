import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del profesor
class RolCubit extends Cubit<String> {
  RolCubit() : super('');

  // Método para actualizar el profesor
  void actualizarRol(String rol) {
    emit(rol);
  }
}
