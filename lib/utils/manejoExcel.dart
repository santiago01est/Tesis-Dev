import 'dart:typed_data';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:excel/excel.dart';

class ManejoExcel {
  static Future<List<String>> leerArchivoExcel(var bytes) async {
    var excel = Excel.decodeBytes(bytes);
    List<String> primeraColumna = [];

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row.isNotEmpty) {
          // Obtener el elemento en la primera posición de la fila
          String elemento = row[0]?.value.toString() ?? '';
          primeraColumna.add(elemento);
        }
      }
    }

    return primeraColumna;
  }

  static List<Estudiante> convertirDatosAObjetos(List<List<dynamic>> data) {
    List<Estudiante> estudiantes = [];

    for (var row in data) {
      String nombre = row[0];
      estudiantes.add(Estudiante(
          nombre: nombre, avatar: "assets/items/perico_mascota.png"));
    }

    return estudiantes;
  }
}
