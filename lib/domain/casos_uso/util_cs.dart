import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/bd_demo.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final cubitRol = context.read<RolCubit>();
    if (context.read<BDCursosCubit>().state.isEmpty) {
      await _fetchCursos();
      await _fetchProfesores();

      cubitRol.actualizarRol('estudiante');
    }
  }

  Future<void> obtenerCursosYProfesoresYUnidades(int cursoId) async {
    if (context.read<RolCubit>().state.isEmpty) {
      context.read<RolCubit>().actualizarRol('estudiante');
    }

    if (context.read<BDCursosCubit>().state.isEmpty) {
      // List<int>? jsonString = await leerStringList('idsEstudiantes');
      // Si la lista no está vacía, convertirla a una lista de Estudiante
      //if (jsonString != null) {

      await _fetchCursos();
      await _fetchProfesores();
      await _fetchCursoYUnidad(cursoId);
      await _fetchSeguimientosCurso(cursoId);

      //Obtener sesion estudiantes si el rol es estudiante
      // Leer y mostrar la lista guardada
    } else {
      await _fetchCursoYUnidad(cursoId);
      await _fetchSeguimientosCurso(cursoId);
    }

    // subir seguimientos para Demo
  }

  Future<void> _fetchCursos() async {
    final cursosBDCubit = context.read<BDCursosCubit>();

    try {
      final cursos = await cursosCasoUso.getCursos();
      cursosBDCubit.subirCursos(cursos);
      print(
          'Estoyyy ${cursosBDCubit.state.runtimeType} ${cursosBDCubit.state}');
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

  Future<void> _fetchCursoYUnidad(int cursoId) async {
    /* forma local */
    final cursosBDCubit = context.read<BDCursosCubit>();
    final cursoCubit = context.read<CursoCubit>();
    final unidades = context.read<UnidadesCubit>();
    try {
      if (context.read<BDCursosCubit>().state.isEmpty) {
        final cursos = await cursosCasoUso.getCursos();
        cursosBDCubit.subirCursos(cursos);
        // buscar en cursos el curso con el id correspondiente
        final curso = cursos.firstWhere((c) => c.id == cursoId);
        cursoCubit.actualizarCurso(curso);
        unidades.subirUnidades(curso.unidades!);
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

/*
  Future<List<int>?> leerStringList(String key) async {
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

  Future<bool> isSesion() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString =
        prefs.getString('idsEstudiantes'); // Obtener la cadena JSON

    if (jsonString != null) {
      return true;
    } else {
      // Si la clave no existe o la cadena JSON es nula, devolver null
      return false;
    }
  }

  Future<void> cerrarSesionEstudiante(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key); // Eliminar la entrada con la clave especificada

    context.read<EstudiantesCubit>().limpiarCubit();
    context.read<CursoCubit>().limpiarCubit();
    context.read<UnidadesCubit>().limpiarCubit();
    context.read<SeguimientosEstudiantesCubit>().limpiarCubit();
    context.read<BDCursosCubit>().limpiarCubit();
    context.read<ProfesoresCubit>().limpiarCubit();
    GoRouter.of(context).pushReplacement('/');
  }
  */

  Future<void> _fetchSeguimientosCurso(int cursoId) async {
    if (context.read<BDemoMundoPC>().state.isEmpty) {
      final curso = context
          .read<BDCursosCubit>()
          .state
          .firstWhere((c) => c.id == cursoId);
      final unidades = curso.unidades;
      List<Actividad> actividades = [];
      // se recorre cada unidad y se pasa actividad a la lista
      for (var unidad in unidades!) {
        for (var actividad in unidad.actividades!) {
          actividades.add(actividad);
        }
      }
      if (cursoId == 1) {
        context.read<BDemoMundoPC>().subirSeguimientos(actividades);
      } else {
        //TODO Conectarme a la bd y traer los seguimientos segun el id
        CursosCasoUso _cursosProfesoresCasoUso = getIt<CursosCasoUso>();

        _cursosProfesoresCasoUso.crearSeguimientos(
            curso.estudiantes!, curso.profesor!, curso.id!, actividades);
      }

      context
          .read<SeguimientosEstudiantesCubit>()
          .subirSeguimientos(context.read<BDemoMundoPC>().state);
    } else {
      final seguimientoCubit = context.read<SeguimientosEstudiantesCubit>();
      List<Seguimiento> seguimientosCurso = [];
      //TODO Conectarme a la bd y traer los seguimientos segun el id
      // Referencia a la colección "cursos" en Firestore
      CollectionReference seguimientosref =
          FirebaseFirestore.instance.collection('seguimientos');

      // Obtener los documentos de la colección
      QuerySnapshot querySnapshot = await seguimientosref.get();

      // Iterar sobre cada documento obtenido
      for (var doc in querySnapshot.docs) {
        // Crear un objeto Curso
        Seguimiento seguimiento = Seguimiento();
        // Leer los datos del documento y guardarlos en el objeto seguimiento

        seguimiento.fromMap(doc.data() as Map<String, dynamic>);
        // Agregar el objeto seguimiento a la lista de seguimientos
        if (seguimiento.cursoId == cursoId) {
          seguimientosCurso.add(seguimiento);
        }
      }
      if (kDebugMode) {
        print('estoyyy ${seguimientosCurso.length}');
      }

      seguimientoCubit.subirSeguimientos(seguimientosCurso);
    }
  }
}
