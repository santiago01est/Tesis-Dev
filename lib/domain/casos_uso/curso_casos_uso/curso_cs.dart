import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/actividad_desconectada.dart';
import 'package:dev_tesis/domain/model/actividad_global_fb.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/curso_firebase.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/model/unidad_firebase.dart';
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
    CollectionReference cursosRef =
        FirebaseFirestore.instance.collection('cursos');

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
    cursosRef.add(cursoMap);

    List<UnidadFirebase> unidadesFB = [];

    // for que recorre cada unidad y de cada unidad toma cada actividad y la agrega a actividadesFB
    for (var i = 0; i < curso.unidades!.length; i++) {
      // se fija la unidad para formatearla y enviarla a firebase
      UnidadFirebase unidadFirebase = UnidadFirebase(
          id: curso.unidades![i].id,
          nombre: curso.unidades![i].nombre,
          descripcion: curso.unidades![i].descripcion,
          estado: curso.unidades![i].estado,
          actividades: [],
          cursoId: curso.unidades![i].cursoId);

      print('whattfucck $unidadFirebase');

      List<ActividadGlobalFB> actividadesFB = [];
      for (var actividad in curso.unidades![i].actividades!) {
        ActividadCuestionario actividadCuestionario = ActividadCuestionario();
        ActividadLaberinto actividadLaberinto = ActividadLaberinto();
        ActividadDesconectada actividadDesconectada = ActividadDesconectada();

        if (actividad.tipoActividad == 'Laberinto') {
          if (actividad is ActividadLaberinto) {
            actividadLaberinto = actividad;
            ActividadGlobalFB actividadGlobalFB = ActividadGlobalFB(
              id: actividad.id,
              nombre: actividad.nombre,
              descripcion: actividad.descripcion,
              estado: actividad.estado,
              tipoActividad: actividad.tipoActividad,
              pesoRespuestas: '',
              habilidades: '[${actividad.habilidades!.join(', ')}]',
              nombreArchivo: actividad.nombreArchivo,
              mejorCamino: convertirListaAMapa(actividad.mejorCamino!),
              mejorCamino2: convertirListaAMapa(actividad.mejorCamino2!),
              initialState: actividad.initialState,
              dimension: 0,
              casillas: '',
              respuestas: {},
              ejercicioImage: '',
              ejemploImage: '',
              pista: actividad.pista,
              respuestaCorrecta: 1,
            );

            actividadesFB.add(actividadGlobalFB);
          }
        }

        if (actividad.tipoActividad == 'Cuestionario') {
          if (actividad is ActividadCuestionario) {
            actividadCuestionario = actividad;

            ActividadGlobalFB actividadGlobalFB = ActividadGlobalFB(
              id: actividad.id,
              nombre: actividad.nombre,
              descripcion: actividad.descripcion,
              estado: actividad.estado,
              tipoActividad: actividad.tipoActividad,
              pesoRespuestas: '[${actividad.pesoRespuestas!.join(', ')}]',
              habilidades: '[${actividad.habilidades!.join(', ')}]',
              nombreArchivo: '',
              mejorCamino: {},
              mejorCamino2: {},
              initialState: 0,
              dimension: actividad.dimension,
              casillas: '[${actividad.casillas!.join(', ')}]',
              respuestas: convertirListadeListaAMapa(actividad.respuestas!),
              ejercicioImage: actividad.ejercicioImage,
              ejemploImage: actividad.ejemploImage,
              pista: actividad.pista,
              respuestaCorrecta: actividad.respuestaCorrecta,
            );
            actividadesFB.add(actividadGlobalFB);
          }
        }

        if (actividad.tipoActividad == 'Desconectada') {
          if (actividad is ActividadDesconectada) {
            actividadDesconectada = actividad;
            ActividadGlobalFB actividadGlobalFB = ActividadGlobalFB(
              id: actividad.id,
              nombre: actividad.nombre,
              descripcion: actividad.descripcion,
              estado: actividad.estado,
              tipoActividad: actividad.tipoActividad,
              pesoRespuestas: '[${actividad.pesoRespuestas!.join(', ')}]',
              habilidades: '[${actividad.habilidades!.join(', ')}]',
              nombreArchivo: '',
              mejorCamino: {},
              mejorCamino2: {},
              initialState: 0,
              dimension: 0,
              casillas: '',
              respuestas: {},
              ejercicioImage: actividad.ejercicioImage,
              ejemploImage: actividad.ejemploImage,
              pista: actividad.pista,
              respuestaCorrecta: 1,
            );
            actividadesFB.add(actividadGlobalFB);
          }
        }
      }
      unidadFirebase.actividades = actividadesFB;
      unidadesFB.add(unidadFirebase);
    }

    // Subir unidades a la BD Firebase
    final collectionRef = FirebaseFirestore.instance.collection('unidades');
    for (var unidadFb in unidadesFB) {
      final unidadMap = unidadFb.toFirestore();
      //print(unidadMap);
      collectionRef.add(unidadMap);
    }
  }

  Map<int, dynamic> convertirListaAMapa(List<dynamic> mejorCamino) {
    Map<int, dynamic> mejorCaminoMapa = {};

    for (int i = 0; i < mejorCamino.length; i++) {
      mejorCaminoMapa[i] = mejorCamino[i];
    }

    return mejorCaminoMapa;
  }

  Map<int, dynamic> convertirListadeListaAMapa(List<List<dynamic>> respuestas) {
    Map<int, dynamic> respuestasMapa = {};

    for (int i = 0; i < respuestas.length; i++) {
      var elemento = respuestas[i];
      if (elemento is List) {
        respuestasMapa[i] = elemento;
      } else if (elemento is Map) {
        respuestasMapa[i] = elemento;
      }
    }

    return respuestasMapa;
  }

  // metodo para subir cada seguimiento
  Future<void> subirSeguimientosFB(List<Seguimiento> seguimientos) async {
    final collectionRef = FirebaseFirestore.instance.collection('seguimientos');

    for (var seguimiento in seguimientos) {
      final seguimientoMap = seguimiento.toFirestore();
      collectionRef.add(seguimientoMap);
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
