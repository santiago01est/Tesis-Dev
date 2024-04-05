import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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