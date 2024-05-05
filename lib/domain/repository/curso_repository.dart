import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:flutter/material.dart';

abstract class CursoRepository {
  Future<List<Curso>> getCursos();

  void guardarCurso(Curso curso);

  Future<Curso> getCursoById(String id);

  void crearSeguimientos(List<Seguimiento> seguimientos);

  Future<List<Seguimiento>> getSeguimientos(
      int cursoId, List<Actividad> actividades, BuildContext context);
}
