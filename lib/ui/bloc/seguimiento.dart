import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeguimientoCubit extends Cubit<Seguimiento> {
  SeguimientoCubit() : super(Seguimiento());

  // Método para actualizar el profesor
  void actualizarSeguimiento(Seguimiento seguimiento) {
    emit(seguimiento);
  }
}