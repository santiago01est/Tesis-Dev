import 'dart:convert';
import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/grupo.dart';
import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/bd_demo.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/grupo_bloc.dart';
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
    cubitRol.actualizarRol('estudiante');
    //final seguimientoCubit = context.watch<SeguimientosEstudiantesCubit>();
    if (context.read<BDCursosCubit>().state.isEmpty) {
      await _fetchCursos();
      await fetchProfesores();

/*
      List<Seguimiento> seguimientosCursos =
          await fetchSeguimientosTodosCursos();
      seguimientoCubit.subirSeguimientos(seguimientosCursos);
*/
      
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

        

      final seguimientoCubit = context.watch<SeguimientosEstudiantesCubit>();

      //await fetchGruposCurso(cursoId);
      await _fetchCursos();
      await fetchProfesores();
      await _fetchCursoYUnidad(cursoId);
      
      await _fetchSeguimientosCurso(cursoId);
      // await _fetchGruposCurso(cursoId);

      //Obtener sesion estudiantes si el rol es estudiante
      // Leer y mostrar la lista guardada

      
    } else {
      //await fetchGruposCurso(cursoId);
      await _fetchCursoYUnidad(cursoId);
      await _fetchSeguimientosCurso(cursoId);
      //await _fetchGruposCurso(cursoId);
    }

    // subir seguimientos para Demo
  }

  Future<void> _fetchCursos() async {
    context.read<BDCursosCubit>();

    try {
      final cursos = await cursosCasoUso.getCursos();
      context.read<BDCursosCubit>().subirCursos(cursos);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  Future<void> fetchProfesores() async {
    try {
      final profesores = await profesorCasoUso.getProfesores();
      context.read<ProfesoresCubit>().subirProfesores(profesores);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener profesores: $e');
    }
  }

  Future<void> obtenerProfesor(int profesorId) async {
    final rolCubit = context.read<RolCubit>();
    rolCubit.actualizarRol("profesor");
    final profesorCubit = context.read<ProfesorCubit>();
    try {
      final ref = FirebaseFirestore.instance
          .collection("profesores")
          .where('id', isEqualTo: profesorId);

      final querySnapshot = await ref.limit(1).get();

      final List<Profesor> profesores = querySnapshot.docs.map((doc) {
        final profesor = Profesor.fromFirestore(doc);
        return profesor;
      }).toList();
      profesorCubit.actualizarProfesor(profesores.first);
/*
      Estudiante yoEstudiante = Estudiante(
          id: profesores.first.id,
          nombre: profesores.first.nombre,
          avatar: profesores.first.avatar,
          genero: 'Otro');

      context.read<EstudiantesCubit>().subirEstudiantes([yoEstudiante]);
      */
       if (context.read<BDCursosCubit>().state.isEmpty) {
        await _fetchCursos();

       }
      
      await fetchProfesores();
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener profesores: $e');
    }
  }

  Future<void> _fetchCursoYUnidad(int cursoId) async {
    /* forma local */

    try {
      final cursos = context.read<BDCursosCubit>().state;
      // buscar en cursos el curso con el id correspondiente
      final curso = cursos.firstWhere((c) => c.id == cursoId);
      context.read<CursoCubit>().actualizarCurso(curso);
      context.read<UnidadesCubit>().subirUnidades(curso.unidades!);
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

  Future<void> subirGrupoCurso(Grupo grupo) async {
    // Referencia a la colección "productos" en Firestore
    CollectionReference productos =
        FirebaseFirestore.instance.collection('grupos');

    // Convertir el objeto Producto a un mapa
    Map<String, dynamic> data = grupo.toMap();

    // Agregar el documento a la colección
    await productos.add(data).then((value) {
    
    }).catchError((error) {
     
    });
  }

Future<void> fetchGruposCurso(int cursoId) async {
  final gruposCubit = context.read<GrupoEstudiantesCubit>();
  final ref = FirebaseFirestore.instance.collection("grupos");
  try {
    final querySnapshot = await ref.get();

    final List<Grupo> grupos = querySnapshot.docs.map((doc) {
      final grupo = Grupo.fromFirestore(doc);
      return grupo;
    }).toList();

    gruposCubit.actualizarGrupos(grupos);
  } catch (e) {
    // Manejo de la excepción
    print('Error al obtener los grupos: $e');
  }
  
}


  Future<void> _fetchSeguimientosCurso(int cursoId) async {
    if (context.read<BDCursosCubit>().state.isEmpty) {
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
        context
            .read<SeguimientosEstudiantesCubit>()
            .subirSeguimientos(context.read<BDemoMundoPC>().state);
      } else {
        //TODO Conectarme a la bd y traer los seguimientos segun el id

        final seguimientoCubit = context.read<SeguimientosEstudiantesCubit>();
        final ref = FirebaseFirestore.instance
            .collection("seguimientos")
            .where('cursoId', isEqualTo: cursoId);

        final querySnapshot = await ref.get();

        final List<Seguimiento> seguimientos = querySnapshot.docs.map((doc) {
          final seguimiento = Seguimiento.fromFirestore(doc);
          return seguimiento;
        }).toList();

        seguimientoCubit.subirSeguimientos(seguimientos);
      }
    } else {
// Para el Curso Demo

      if (cursoId == 1) {
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
        if (context.read<BDemoMundoPC>().state.isEmpty) {
          context.read<BDemoMundoPC>().subirSeguimientos(actividades);
          context
              .read<SeguimientosEstudiantesCubit>()
              .subirSeguimientos(context.read<BDemoMundoPC>().state);
        }
      } else {
        // para los cursos subidos en la BD

        final seguimientoCubit = context.read<SeguimientosEstudiantesCubit>();
        final ref = FirebaseFirestore.instance
            .collection("seguimientos")
            .where('cursoId', isEqualTo: cursoId);

        final querySnapshot = await ref.get();

        final List<Seguimiento> seguimientos = querySnapshot.docs.map((doc) {
          final seguimiento = Seguimiento.fromFirestore(doc);
          return seguimiento;
        }).toList();

        seguimientoCubit.subirSeguimientos(seguimientos);
      }
    }
  }

  Future<List<Seguimiento>> fetchSeguimientosTodosCursos() async {


        final curso = context
            .read<BDCursosCubit>()
            .state
            .firstWhere((c) => c.id == 1);
        final unidades = curso.unidades;
        List<Actividad> actividades = [];
        // se recorre cada unidad y se pasa actividad a la lista
        for (var unidad in unidades!) {
          for (var actividad in unidad.actividades!) {
            actividades.add(actividad);
          }
        }
        if (context.read<BDemoMundoPC>().state.isEmpty) {
          context.read<BDemoMundoPC>().subirSeguimientos(actividades);
          context
              .read<SeguimientosEstudiantesCubit>()
              .subirSeguimientos(context.read<BDemoMundoPC>().state);
        }
      
    final ref = FirebaseFirestore.instance.collection("seguimientos");

    final querySnapshot = await ref.get();

    final List<Seguimiento> seguimientos = querySnapshot.docs.map((doc) {
      final seguimiento = Seguimiento.fromFirestore(doc);
      return seguimiento;
    }).toList();

    seguimientos.add(context.read<BDemoMundoPC>().state.first);
    

    return seguimientos;
  }
}
