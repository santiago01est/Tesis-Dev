import 'dart:convert';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitData {
  final CursosCasoUso cursosCasoUso;
  final ProfesorCasoUso profesorCasoUso;
  final BuildContext context;

  InitData({
    required this.cursosCasoUso,
    required this.profesorCasoUso,
    required this.context,
  });

  Future<void> obtenerCursosYProfesores() async {
    if (context.read<BDCursosCubit>().state.isEmpty) {
      await _fetchCursos();
      await _fetchProfesores();
      //TODO: obtener sesion estudiantes si el rol es estudiante
      context.read<RolCubit>().actualizarRol('estudiante');
    }
  }

  Future<void> obtenerCursosYProfesoresYUnidades(String id) async {
    if (context.read<BDCursosCubit>().state.isEmpty) {
      await _fetchCursos();
      await _fetchProfesores();
      await _fetchCursoYUnidad(id);
      await _fetchSeguimientosCurso(id);
      //TODO: obtener sesion estudiantes si el rol es estudiante
      context.read<RolCubit>().actualizarRol('estudiante');
      //Obtener sesion estudiantes si el rol es estudiante
      // Leer y mostrar la lista guardada
      List<int>? jsonString = await readStringList('idsEstudiantes');
      // Si la lista no está vacía, convertirla a una lista de Estudiante
      if (jsonString != null) {
        List<Estudiante> estudiantes =
            context.read<CursoCubit>().obtenerEstudiantesPorIds(jsonString!);
        context.read<EstudiantesCubit>().subirEstudiantes(estudiantes);
      } else {
        //TODO: obtener sesion estudiantes si el rol es estudiante
        //TODO: obtener sesion del profesor
        context.read<RolCubit>().actualizarRol('profesor');
      }
    } else {
      await _fetchCursoYUnidad(id);
      await _fetchSeguimientosCurso(id);
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

  Future<void> _fetchCursoYUnidad(String cursoId) async {
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

  Future<List<int>?> readStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key); // Obtener la cadena JSON

    if (jsonString != null) {
      // Decodificar la cadena JSON en una lista de String
      List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList.map((item) => item as int).toList();
    } else {
      // Si la clave no existe o la cadena JSON es nula, devolver null
      return null;
    }
  }

  Future<void> _fetchSeguimientosCurso(String cursoId) async {
    context.read<SeguimientosEstudiantesCubit>().subirSeguimientos([
      Seguimiento(
          id: 1,
          respuestasActividades: List.generate(80, (index) => -1),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 1,
          cursoId: 0),
      Seguimiento(
          id: 2,
          respuestasActividades: List.generate(80, (index) => -1),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 2,
          cursoId: 0),
      Seguimiento(
          id: 3,
          respuestasActividades: List.generate(80, (index) => -1),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 3,
          cursoId: 0),
      Seguimiento(
          id: 4,
          respuestasActividades: List.generate(80, (index) => -1),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 4,
          cursoId: 0),
      Seguimiento(
          id: 5,
          respuestasActividades: List.generate(80, (index) => -1),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 5,
          cursoId: 0),
      Seguimiento(
          id: 6,
          respuestasActividades: List.generate(80, (index) => -1),
          test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          calificacion: 0,
          userId: 6,
          cursoId: 0),
    ]);
  }
}
