import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Evento para cambiar el nombre completo
class CambiarNombreEvent extends Equatable {
  final String newName;

  CambiarNombreEvent(this.newName);

  @override
  List<Object?> get props => [newName];
}

// Cubit para manejar el estado del nombre completo
class NombreCompletoCubit extends Cubit<String> {
  NombreCompletoCubit() : super("");

  // Método para cambiar el nombre
  void changeName(String newName) {
    emit(newName);
  }
}
