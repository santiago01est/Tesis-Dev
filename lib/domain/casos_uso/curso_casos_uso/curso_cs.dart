import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CursosCasoUso {
  final CursoRepository cursoRepository;

  CursosCasoUso({required this.cursoRepository});

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

  // crear Seguimientos del curso
  List<Seguimiento> crearSeguimientos(List<Estudiante> estudiantes,
      int idProfesor, int idCurso, List<Actividad> actividades) {
    /*
    Recorre la lista de estudiantes y crea un seguimiento para cada uno de ellos
    */
    List<Seguimiento> seguimientos = [];
    for (int i = 0; i < estudiantes.length; i++) {
      seguimientos.add(
        Seguimiento(
            id: i,
            respuestasActividades: List.generate(
                actividades.length,
                (index) => Respuesta(
                    id: i,
                    respuestaUsuario: '',
                    peso: -1,
                    actividadId: actividades[index].id!,
                    seguimientoId: i)),
            test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            calificacion: 0,
            userId: estudiantes[i].id,
            cursoId: idCurso),
      );
    }

    seguimientos.add(Seguimiento(
        id: seguimientos.length + 1,
        respuestasActividades: List.generate(
            actividades.length,
            (index) => Respuesta(
                id: 1,
                respuestaUsuario: '',
                peso: -1,
                actividadId: actividades[index].id!,
                seguimientoId: seguimientos.length + 1)),
        test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        calificacion: 0,
        userId: idProfesor,
        cursoId: idCurso));

    return seguimientos;
    // Copia en Cubit
  }

  //Metodo que agrega una actividad en el seguimiento del grupo
  void agregarActividad(int idCurso, Actividad actividad, int unidadId) {
    /*
    context.read<UnidadesCubit>().addActividad(
        Actividad(
            id: actividad.id,
            nombre: actividad.nombre,
            descripcion: actividad.descripcion,
            estado: actividad.estado,
            pesoRespuestas: actividad.pesoRespuestas,
            habilidades: actividad.habilidades,
            tipoActividad: actividad.tipoActividad),
        unidadId);
*/
  }

  //** FIREBASE */
  // Método para subir el objeto a Firestore
  Future<void> subirCursoFB(Curso curso) async {
    // Referencia a la colección "cursos" en Firestore
    CollectionReference cursosRef =
        FirebaseFirestore.instance.collection('cursos');

    final cursoMap = curso.toFirestore();
    await cursosRef.add(cursoMap);

/*
    // Convertir el objeto Producto a un mapa
    Map<String, dynamic> data = curso.toMap();

    // Agregar el documento a la colección
    await cursos.add(data).then((value) {}).catchError((error) {
      print('Error al agregar el Curso: $error');
    });

    */
  }

  // metodo para subir cada seguimiento
  Future<void> subirSeguimientosFB(List<Seguimiento> seguimientos) async {
    final collectionRef = FirebaseFirestore.instance.collection('seguimientos');

    for (var seguimiento in seguimientos) {
      final seguimientoMap = seguimiento.toFirestore();
      await collectionRef.add(seguimientoMap);
    }
  }

// actualizar una respuesta en el seguimiento
  Future<void> actualizarRespuesta(int cursoId, List<int> estudianteId,
      int actividadId, int peso, String respuestaEstudiante) async {
    final collectionRef = FirebaseFirestore.instance.collection('seguimientos');

    for (var estudiante in estudianteId) {
      // Buscar documentos
      final querySnapshot = await collectionRef
          .where('cursoId', isEqualTo: cursoId)
          .where('userId', isEqualTo: estudiante)
          .get();

// Iterar sobre los documentos encontrados (debería ser solo uno en este caso)
      for (var doc in querySnapshot.docs) {
        // Obtener la referencia al documento
        final docRef = collectionRef.doc(doc.id);
        final seguimiento = Seguimiento.fromFirestore(doc);
        List<Respuesta> misRespuestas = seguimiento.respuestasActividades!;
        List<Respuesta> respuestaActualizada = [];

        for (var respuesta in misRespuestas) {
          if (respuesta.actividadId == actividadId) {
            respuesta.peso = peso;
            respuesta.respuestaUsuario = respuestaEstudiante;
            respuestaActualizada.add(respuesta);
          } else {
            respuestaActualizada.add(respuesta);
          }
        }

// agrega respuestas actualizadas al seguimiento
// Actualizar el campo respuestasActividades en el documento de seguimiento
        await docRef.update({
          'respuestasActividades': respuestaActualizada
              .map((respuesta) => respuesta.toFirestore())
              .toList(),
        });
      }
    }
  }
}
