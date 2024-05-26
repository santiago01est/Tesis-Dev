import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';

abstract class CursoRepository {
  Future<List<Curso>> getCursos();

  Future<void> guardarCurso(Curso curso);

  Future<Curso> getCursoById(String id);


  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos);

  Future<void> eliminarRespuestaActividadSeguimiento(
      int cursoId, int actividadId);

  Future<void> eliminarActividad(int cursoId, int actividadId);

  Future<void> subirActividadCuestionario(int unidadId,
      ActividadCuestionario actividadCuestionarioSave, int cursoId);

  Future<void> subirSeguimientosActividadCuestionario(
      ActividadCuestionario actividadCuestionarioSave, int cursoId);
}
