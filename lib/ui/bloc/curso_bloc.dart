import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class NombreCompletoCubit extends Cubit<String> {
  NombreCompletoCubit() : super("");

  // Método para cambiar el nombre
  void changeName(String newName) {
    emit(newName);
  }
}
