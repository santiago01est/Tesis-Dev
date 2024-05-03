import 'dart:convert';

import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstudiantesCubit extends Cubit<List<Estudiante>> {
  EstudiantesCubit() : super([]);

  void subirEstudiantes(List<Estudiante> list) {
    emit(list);
  }

  void limpiarCubit() {
    emit([]);
  }

  void agregarEstudiante(Estudiante nuevoEstudiante) {
    List<Estudiante> estudiantes = List.from(state); // Crea una nueva lista
    estudiantes.add(nuevoEstudiante);
    emit(estudiantes);
    List<int> ids = obtenerIds();
    saveStringList('idsEstudiantes', ids);
  }

  //Guarda los id de los estudiantes en el localstorage

  Future<void> saveStringList(String key, List<int> list) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(list); // Convertir lista a JSON
    await prefs.setString(key, jsonString); // Guardar JSON en LocalStorage
  }

  //metodo que retorna una lista con los ids de los estudiantes
  List<int> obtenerIds() {
    List<int> ids = [];
    for (Estudiante estudiante in state) {
      ids.add(estudiante.id!);
    }
    return ids;
  }

  // Retornar nombre de los estudiantes como string
  String obtenerNombres() {
    String nombres = '';
    for (Estudiante estudiante in state) {
      // si el estudiantes es el ultimo no se agrega coma
      if (state.indexOf(estudiante) != state.length - 1) {
        nombres += '${estudiante.nombre} - ';
      } else {
        nombres += '${estudiante.nombre}';
      }
    }
    return nombres;
  }
}
