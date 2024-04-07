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

class SeguimientosEstudiantesCubit extends Cubit<List<Seguimiento>>{
  //TODO: IMPLEMENTAR SEGUIMIENTOS ESTUDIANTES [RECUPERAR DESDE LA BD SEGUN EL CURSOID]
  SeguimientosEstudiantesCubit(): super([]);


  void subirSeguimientos(){
    emit([
    Seguimiento(id: 1, respuestasActividades: List.generate(80, (index) => -1), test: [], calificacion: 0, userId:1, cursoId: 0),
    Seguimiento(id: 2, respuestasActividades: List.generate(80, (index) => -1), test: [], calificacion: 0, userId:2, cursoId:0 ),
    Seguimiento(id: 3, respuestasActividades: List.generate(80, (index) => -1), test: [], calificacion: 0, userId:3, cursoId:0 ),
    Seguimiento(id: 4, respuestasActividades: List.generate(80, (index) => -1), test: [], calificacion: 0,  userId:4, cursoId:0),
    Seguimiento(id: 5, respuestasActividades: List.generate(80, (index) => -1), test: [], calificacion: 0, userId:5, cursoId:0),
    Seguimiento(id: 6, respuestasActividades: List.generate(80, (index) => -1), test: [], calificacion: 0,   userId:6, cursoId:0),
  ]);
  }

   void actualizarRespuestasActividades(int userId, List<int> nuevasRespuestas) {
    emit(state.map((seguimiento) {
      if (seguimiento.userId == userId) {
        return seguimiento.copyWith(respuestasActividades: nuevasRespuestas);
      } else {
        return seguimiento;
      }
    }).toList());
  }

}