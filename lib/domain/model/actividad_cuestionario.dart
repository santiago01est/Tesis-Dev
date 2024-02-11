//clase cuestionario que extiende de actividad
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/casilla.dart';

class ActividadCuestionario extends Actividad {
  int dimension;
  int casillaGanadora;
  int casillaInicio;
  List<Casilla> casillas;

  ActividadCuestionario(
      {required super.id,
      required super.nombre,
      required super.descripcion,
      required super.estado,
      required super.tipoActividad,
      required this.dimension,
      required this.casillaGanadora,
      required this.casillaInicio,
      required this.casillas});
}
