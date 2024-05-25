import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:flutter/material.dart';

abstract class CursoRepository {
  Future<List<Curso>> getCursos();

  Future<void> guardarCurso(Curso curso);

  Future<Curso> getCursoById(String id);

  Future<List<Seguimiento>> getSeguimientos(
      int cursoId, List<Actividad> actividades, BuildContext context);

  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos);

  Future<void> eliminarRespuestaActividadSeguimiento(int cursoId, int actividadId);

  Future<void> eliminarActividad(int cursoId, int actividadId);
}
