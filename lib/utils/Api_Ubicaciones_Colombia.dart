import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiUbicacionesColombia {
  static Future<List<String>> fetchDepartamentos() async {
    final response = await http
        .get(Uri.parse('https://www.datos.gov.co/resource/xdk5-pm3f.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> departamentosList = [];

      for (final departamento in data) {
        departamentosList.add(departamento['departamento']);
      }
      Set<String> conjuntoDeptoUnico = Set<String>.from(departamentosList);
      // Convertir el conjunto de nuevo a una lista
      return conjuntoDeptoUnico.toList();
    }
    return [];
  }

  static Future<List<String>> fetchMunicipios(String departamento) async {
    final response = await http.get(Uri.parse(
        'https://www.datos.gov.co/resource/xdk5-pm3f.json?departamento=$departamento'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> municipiosList = [];

      for (final municipio in data) {
        municipiosList.add(municipio['municipio']);
      }

      Set<String> conjuntoDeptoUnico = Set<String>.from(municipiosList);
      // Convertir el conjunto de nuevo a una lista
      return conjuntoDeptoUnico.toList();
    }
    return [];
  }
}
