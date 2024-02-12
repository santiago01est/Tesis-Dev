//clase cuestionario que extiende de actividad
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/casilla.dart';

class ActividadCuestionario extends Actividad {
  int dimension;
  int casillaInicio;
  int casillaFinal;
  List<Casilla> casillas;
  List<String> respuestaA;
  List<String> respuestaB;
  List<String> respuestaC;
  List<String> respuestaD;

  ActividadCuestionario(
      {required super.id,
      required super.nombre,
      required super.descripcion,
      required super.estado,
      required super.tipoActividad,
      required this.dimension,
      required this.casillaFinal,
      required this.casillaInicio,
      required this.casillas,
      required this.respuestaA,
      required this.respuestaB,
      required this.respuestaC,
      required this.respuestaD});
}
