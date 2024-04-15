import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CursosProfesoresCasoUso {
  final CursosCasoUso cursosCasoUso;
  final ProfesorCasoUso profesorCasoUso;
  final BuildContext context;

  CursosProfesoresCasoUso({
    required this.cursosCasoUso,
    required this.profesorCasoUso,
    required this.context,
  });

  Future<void> obtenerCursosYProfesores() async {
    if (context.read<BDCursosCubit>().state.isEmpty) {
      await _fetchCursos();
      await _fetchProfesores();
    }
  }

  Future<void> obtenerCursosYProfesoresYUnidades(String id) async {
    if (context.read<BDCursosCubit>().state.isEmpty) {
      await _fetchCursos();
      await _fetchProfesores();
      await _fetchCursoYUnidad(id);
    }
  }

  Future<void> _fetchCursos() async {
    try {
      final cursos = await cursosCasoUso.getCursos();
      context.read<BDCursosCubit>().subirCursos(cursos);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  Future<void> _fetchProfesores() async {
    try {
      final profesores = await profesorCasoUso.getProfesores();
      context.read<ProfesoresCubit>().subirProfesores(profesores);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener profesores: $e');
    }
  }

   Future<void>  _fetchCursoYUnidad(String cursoId) async {
    /* forma local */
    try {

      if (context.read<BDCursosCubit>().state.isEmpty) {
        final cursos = await cursosCasoUso.getCursos();
        context.read<BDCursosCubit>().subirCursos(cursos);
        // buscar en cursos el curso con el id correspondiente
        final curso = cursos.firstWhere((c) => c.id == cursoId);
        context.read<CursoCubit>().actualizarCurso(curso);
        context.read<UnidadesCubit>().subirUnidades(curso.unidades!);
      } else {
        final cursos = context.read<BDCursosCubit>().state;
        // buscar en cursos el curso con el id correspondiente
        final curso = cursos.firstWhere((c) => c.id == cursoId);
        context.read<CursoCubit>().actualizarCurso(curso);
        context.read<UnidadesCubit>().subirUnidades(curso.unidades!);
      }
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }
}