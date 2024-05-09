import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/actividad_desconectada.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:dev_tesis/ui/bloc/bd_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CursosDataAdapter extends CursoRepository {
  @override
  Future<List<Curso>> getCursos() async {
    /* TODO: implement getCursos BD mientras sera por mapas */

    
    List<Curso> cursos = [];

    // obtener los cursos de la base de datos

    // Referencia a la colección "cursos" en Firestore
  CollectionReference cursosRef =
      FirebaseFirestore.instance.collection('cursos');

  // Obtener los documentos de la colección
  QuerySnapshot querySnapshot = await cursosRef.get();

  // Iterar sobre cada documento obtenido
  for (var doc in querySnapshot.docs) {
    // Crear un objeto Curso
    Curso curso = Curso();
    // Leer los datos del documento y guardarlos en el objeto Curso
    print((doc.data() as Map<String, dynamic>));
    curso.fromMap(doc.data() as Map<String, dynamic>);
    // Agregar el objeto Curso a la lista de cursos
    cursos.add(curso);
  }
    

    return cursos;
  }

  @override
  void guardarCurso(Curso curso) {
    // TODO: implement guardarCurso
  }

  @override
  Future<Curso> getCursoById(String id) {
    // TODO: implement getCursoById
    throw UnimplementedError();
  }

  @override
  void crearSeguimientos(List<Seguimiento> seguimientos) {}

  //obtener seguimientos
  @override
  Future<List<Seguimiento>> getSeguimientos(
      int cursoId, List<Actividad> actividades, BuildContext context) {
    if (cursoId == 1) {
      return Future.value([
        Seguimiento(
            id: 1,
            respuestasActividades: List.generate(
                actividades.length,
                (index) => Respuesta(
                    id: 1,
                    respuestaUsuario: '',
                    peso: -1,
                    actividadId: actividades[index].id!,
                    seguimientoId: 1)),
            test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            calificacion: 0,
            userId: 1,
            cursoId: 1),
        Seguimiento(
            id: 2,
            respuestasActividades: List.generate(
                actividades.length,
                (index) => Respuesta(
                    id: 2,
                    respuestaUsuario: '',
                    peso: -1,
                    actividadId: actividades[index].id!,
                    seguimientoId: 2)),
            test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            calificacion: 0,
            userId: 2,
            cursoId: 1),
      ]);
    } else {
      // Buscar en la BD los Seguimientos del curso
      return Future.value(
          context.read<BDemoMundoPC>().obtenerSeguimiento(cursoId));
    }
  }
}
