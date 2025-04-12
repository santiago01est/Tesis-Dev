import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/grupo.dart';
import '/domain/repository/grupo_repository.dart';

class GrupoHttpAdapter extends GrupoRepository {
  final String baseUrl = 'http://localhost:8080';

  @override
  Future<List<Grupo>> getGrupos(int idCurso) async {
    // Suponiendo que el endpoint para grupos sea algo como:
    // GET http://localhost:8080/grupos?cursoId={idCurso}
    final url = Uri.parse('$baseUrl/grupos?cursoId=$idCurso');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Grupo.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener grupos: ${response.statusCode}');
    }
  }

  @override
  void guardarGrupo(Grupo grupo) {
    // Implementar si tienes un endpoint para crear grupo.
    // Por ejemplo:
    // POST http://localhost:8080/grupos
  }

  @override
  void eliminarGrupo(int idGrupo) {
    // Implementar si existe un endpoint para eliminar grupo.
    // Por ejemplo:
    // DELETE http://localhost:8080/grupos/{idGrupo}
  }
}