import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/actividad_desconectada.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/curso_firebase.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';


class FirebaseService {
  final FirebaseFirestore firestore;

  FirebaseService({required this.firestore});

  Future<void> subirCursoFB(Curso curso) async {
    CollectionReference cursosRef = firestore.collection('cursos');

    CursoFirebase cursoFirebase = CursoFirebase(
      id: curso.id,
      nombre: curso.nombre,
      codigoAcceso: curso.codigoAcceso,
      departamento: curso.departamento,
      ciudad: curso.ciudad,
      colegio: curso.colegio,
      profesor: curso.profesor,
      portada: curso.portada,
      numEstudiantes: curso.numEstudiantes,
      descripcion: curso.descripcion,
      fechaCreacion: curso.fechaCreacion,
      fechaFinalizacion: curso.fechaFinalizacion,
      estado: curso.estado,
      estudiantes: curso.estudiantes,
    );

    //Subir curso
    final cursoMap = cursoFirebase.toFirestore();
    await cursosRef.add(cursoMap);
  }

  Future<void> subirUnidadesFB(Curso curso) async{
    List<Map<String, dynamic>> unidadesFB = [];

    // for que recorre cada unidad y de cada unidad toma cada actividad y la agrega a actividadesFB
    for (var i = 0; i < curso.unidades!.length; i++) {
      // se fija la unidad para formatearla y enviarla a firebase
      Map<String, dynamic> unidadFirebase = {
        'id': curso.unidades![i].id,
        'nombre': curso.unidades![i].nombre,
        'descripcion': curso.unidades![i].descripcion,
        'estado': curso.unidades![i].estado,
        'actividades': [],
        'cursoId': curso.unidades![i].cursoId
      };

      List<Map<String, dynamic>> actividadesFB = [];

      for (var actividad in curso.unidades![i].actividades!) {
        ActividadCuestionario actividadCuestionario = ActividadCuestionario();
        ActividadLaberinto actividadLaberinto = ActividadLaberinto();
        ActividadDesconectada actividadDesconectada = ActividadDesconectada();

        Map<String, dynamic> actividadGlobalFB = {};

        if (actividad.tipoActividad == 'Laberinto') {
          if (actividad is ActividadLaberinto) {
            actividadLaberinto = actividad;

            actividadGlobalFB = {
              'id': actividadLaberinto.id,
              'nombre': actividadLaberinto.nombre,
              'descripcion': actividadLaberinto.descripcion,
              'estado': actividadLaberinto.estado,
              'tipoActividad': actividadLaberinto.tipoActividad,
              'pesoRespuestas': '',
              'habilidades':
                  convertirListaAStringPlano(actividadLaberinto.habilidades!),
              'nombreArchivo': actividadLaberinto.nombreArchivo,
              'mejorCamino':
                  convertirListaAStringPlano(actividadLaberinto.mejorCamino!),
              'mejorCamino2':
                  convertirListaAStringPlano(actividadLaberinto.mejorCamino2!),
              'initialState': actividadLaberinto.initialState,
              'dimension': 0,
              'casillas': '',
              'respuestas': '',
              'ejercicioImage': '',
              'ejemploImage': '',
              'pista': actividadLaberinto.pista,
              'respuestaCorrecta': 1,
            };

            actividadesFB.add(actividadGlobalFB);
          }
        }

        if (actividad.tipoActividad == 'Cuestionario') {
          if (actividad is ActividadCuestionario) {
            actividadCuestionario = actividad;

            actividadGlobalFB = {
              'id': actividadCuestionario.id,
              'nombre': actividadCuestionario.nombre,
              'descripcion': actividadCuestionario.descripcion,
              'estado': actividadCuestionario.estado,
              'tipoActividad': actividadCuestionario.tipoActividad,
              'pesoRespuestas': convertirListaAStringPlano(
                  actividadCuestionario.pesoRespuestas!),
              'habilidades': convertirListaAStringPlano(
                  actividadCuestionario.habilidades!),
              'nombreArchivo': '',
              'mejorCamino': '',
              'mejorCamino2': '',
              'initialState': 0,
              'dimension': actividadCuestionario.dimension,
              'casillas':
                  convertirListaAStringPlano(actividadCuestionario.casillas!),
              'respuestas':
                  convertirListaAStringPlano(actividadCuestionario.respuestas!),
              'ejercicioImage': actividadCuestionario.ejercicioImage,
              'ejemploImage': actividadCuestionario.ejemploImage,
              'pista': actividadCuestionario.pista,
              'respuestaCorrecta': actividadCuestionario.respuestaCorrecta,
            };
            actividadesFB.add(actividadGlobalFB);
          }
        }

        if (actividad.tipoActividad == 'Desconectada') {
          if (actividad is ActividadDesconectada) {
            actividadDesconectada = actividad;

            actividadGlobalFB = {
              'id': actividadDesconectada.id,
              'nombre': actividadDesconectada.nombre,
              'descripcion': actividadDesconectada.descripcion,
              'estado': actividadDesconectada.estado,
              'tipoActividad': actividadDesconectada.tipoActividad,
              'pesoRespuestas': convertirListaAStringPlano(
                  actividadDesconectada.pesoRespuestas!),
              'habilidades': convertirListaAStringPlano(
                  actividadDesconectada.habilidades!),
              'nombreArchivo': '',
              'mejorCamino': '',
              'mejorCamino2': '',
              'initialState': 0,
              'dimension': 0,
              'casillas': '',
              'respuestas': '',
              'ejercicioImage': actividadDesconectada.ejercicioImage,
              'ejemploImage': actividadDesconectada.ejemploImage,
              'pista': actividadDesconectada.pista,
              'respuestaCorrecta': 1,
            };

            actividadesFB.add(actividadGlobalFB);
          }
        }
      }
      unidadFirebase['actividades'] = actividadesFB;
      unidadesFB.add(unidadFirebase);
    }

    // Subir unidades a la BD Firebase
    final collectionRef = FirebaseFirestore.instance.collection('unidades');
    for (var unidadFb in unidadesFB) {
      //print(unidadMap);
      collectionRef.add(unidadFb);
    }
  }

  String convertirListaAStringPlano(List<dynamic> respuestas) {
    // Convertir la lista a un string
    String listAsString = jsonEncode(respuestas);

    return listAsString;
  }

  Future<void> subirActividadCuestionarioFB(int unidadId,
      ActividadCuestionario actividadCuestionarioSave, int cursoId)async{
    // Actualizar actividad en unidad

    CollectionReference collectionUnidadesRef =
        FirebaseFirestore.instance.collection("unidades");

    // Realizar la consulta para encontrar el documento con el campo específico
    QuerySnapshot queryUnidadesSnapshot = await collectionUnidadesRef
        .where('cursoId', isEqualTo: cursoId)
        .where('id', isEqualTo: unidadId)
        .limit(1)
        .get();
    Map<String, dynamic> actividadGlobalFB = {};

    actividadGlobalFB = {
      'id': actividadCuestionarioSave.id,
      'nombre': actividadCuestionarioSave.nombre,
      'descripcion': actividadCuestionarioSave.descripcion,
      'estado': actividadCuestionarioSave.estado,
      'tipoActividad': actividadCuestionarioSave.tipoActividad,
      'pesoRespuestas':
          convertirListaAStringPlano(actividadCuestionarioSave.pesoRespuestas!),
      'habilidades':
          convertirListaAStringPlano(actividadCuestionarioSave.habilidades!),
      'nombreArchivo': '',
      'mejorCamino': '',
      'mejorCamino2': '',
      'initialState': 0,
      'dimension': actividadCuestionarioSave.dimension,
      'casillas':
          convertirListaAStringPlano(actividadCuestionarioSave.casillas!),
      'respuestas':
          convertirListaAStringPlano(actividadCuestionarioSave.respuestas!),
      'ejercicioImage': actividadCuestionarioSave.ejercicioImage,
      'ejemploImage': actividadCuestionarioSave.ejemploImage,
      'pista': actividadCuestionarioSave.pista,
      'respuestaCorrecta': actividadCuestionarioSave.respuestaCorrecta,
    };

    if (queryUnidadesSnapshot.docs.isNotEmpty) {
      // Iterar a través de los documentos encontrados y eliminarlos
      for (QueryDocumentSnapshot doc in queryUnidadesSnapshot.docs) {
        final docRef = collectionUnidadesRef.doc(doc.id);
        docRef.update({
          'actividades': FieldValue.arrayUnion([actividadGlobalFB]),
        });
      }
    }
  }

  Future<void> subirSeguimientosActividadCuestionarioFB(
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {

    CollectionReference collectionSegRef =
        FirebaseFirestore.instance.collection("seguimientos");

    // Realizar la consulta para encontrar el documento con el campo específico
    QuerySnapshot querySegSnapshot =
        await collectionSegRef.where('cursoId', isEqualTo: cursoId).get();

    // nuemro de seguimiento encontrados
    int numSeg = querySegSnapshot.docs.length;

    Respuesta nuevaRespuesta = Respuesta(
        id: 1,
        respuestaUsuario: '',
        peso: -1,
        actividadId: actividadCuestionarioSave.id!,
        seguimientoId: numSeg);

    if (querySegSnapshot.docs.isNotEmpty) {
      
      for (QueryDocumentSnapshot doc in querySegSnapshot.docs) {
        final docRef = collectionSegRef.doc(doc.id);
        docRef.update({
          'respuestasActividades': FieldValue.arrayUnion([nuevaRespuesta.toFirestore()]),
        });
      }
    }

  }

Future<void> eliminarActividadFB(int cursoId, int actividadId) async {
  
    //eliminar respuesta del seguimiento

    CollectionReference collectionSegRef =
        FirebaseFirestore.instance.collection("unidades");

    // Realizar la consulta para encontrar el documento con el campo específico
    QuerySnapshot querySegSnapshot =
        await collectionSegRef.where('cursoId', isEqualTo: cursoId).get();

    if (querySegSnapshot.docs.isNotEmpty) {
      // Iterar a través de los documentos encontrados y eliminarlos
      for (QueryDocumentSnapshot doc in querySegSnapshot.docs) {
        List<dynamic> actividades = doc.get('actividades');
        print(actividades);

        // Encontrar la respuesta a eliminar
        dynamic actividadAEliminar;
        for (var actividad in actividades) {
          if (actividad['id'] == actividadId) {
            actividadAEliminar = actividad;
            break;
          }
        }
        final docRef = collectionSegRef.doc(doc.id);
        await docRef.update({
          'actividades': FieldValue.arrayRemove([actividadAEliminar]),
        });
      }
    }
  }

Future<void> eliminarRespuestaActividadSeguimientoFB(
      int cursoId, int actividadId) async {
    //eliminar respuesta del seguimiento

    CollectionReference collectionSegRef =
        FirebaseFirestore.instance.collection("seguimientos");

    // Realizar la consulta para encontrar el documento con el campo específico
    QuerySnapshot querySegSnapshot =
        await collectionSegRef.where('cursoId', isEqualTo: cursoId).get();

    if (querySegSnapshot.docs.isNotEmpty) {
      // Iterar a través de los documentos encontrados y eliminarlos
      for (QueryDocumentSnapshot doc in querySegSnapshot.docs) {
        List<dynamic> respuestasActividades = doc.get('respuestasActividades');
        print(respuestasActividades);

        // Encontrar la respuesta a eliminar
        dynamic respuestaAEliminar;
        for (var respuesta in respuestasActividades) {
          if (respuesta['actividadId'] == actividadId) {
            respuestaAEliminar = respuesta;
            break;
          }
        }
        final docRef = collectionSegRef.doc(doc.id);
        await docRef.update({
          'respuestasActividades': FieldValue.arrayRemove([respuestaAEliminar]),
        });
      }
    }
  }


Future<void> guardarSeguimientosFB(List<Seguimiento> seguimientos) async {
    final collectionRef = FirebaseFirestore.instance.collection('seguimientos');

    for (var seguimiento in seguimientos) {
      final seguimientoMap = seguimiento.toFirestore();
      collectionRef.add(seguimientoMap);
    }
}
}