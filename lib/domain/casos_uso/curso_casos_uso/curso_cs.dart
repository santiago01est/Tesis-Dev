import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:flutter/material.dart';

class CursosCasoUso {
  final CursoRepository cursoRepository;
  final BuildContext context;
  CursosCasoUso(this.cursoRepository, this.context);

  Future<List<Curso>> getCursos() async {
    return await cursoRepository.getCursos();
  }

  void guardarCurso(Curso curso) {
    cursoRepository.guardarCurso(curso);
  }

  //obtener curso por su id
  Future<Curso> getCursoById(String id) {
    return cursoRepository.getCursoById(id);
  }
}
