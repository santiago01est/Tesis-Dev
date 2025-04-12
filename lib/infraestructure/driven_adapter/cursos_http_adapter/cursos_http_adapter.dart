import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/curso.dart';
import '/domain/model/seguimiento.dart';
import '/domain/model/actividad_cuestionario.dart';
import '/domain/repository/curso_repository.dart';

class CursosHttpAdapter extends CursoRepository {
  final String baseUrl = 'http://localhost:8080';

  @override
  Future<List<Curso>> getCursos() async {
    final url = Uri.parse('$baseUrl/cursos');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Asumimos que Curso tiene un método fromJson
      return data.map((json) => Curso.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener cursos: ${response.statusCode}');
    }
  }

  @override
  Future<void> guardarCurso(Curso curso) async {
    final url = Uri.parse('$baseUrl/cursos');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(curso.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear curso: ${response.statusCode}');
    }
  }

  @override
  Future<Curso> getCursoById(String id) async {
    final url = Uri.parse('$baseUrl/cursos/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Curso.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Curso no encontrado (status: ${response.statusCode})');
    }
  }

  @override
  Future<void> guardarSeguimientos(List<Seguimiento> seguimientos) async {
    // En este caso se hará un POST único para cada seguimiento o en bloque si el back lo permite
    for (var seguimiento in seguimientos) {
      final url = Uri.parse('$baseUrl/seguimientos');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(seguimiento.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Error al crear seguimiento: ${response.statusCode}');
      }
    }
  }

  @override
  Future<void> eliminarRespuestaActividadSeguimiento(int cursoId, int actividadId) async {
    // Suponiendo que en tu backend esta operación se implementa en un endpoint DELETE,
    // Por ejemplo, podrías tener: DELETE /seguimientos?cursoId=...&actividadId=...
    final url = Uri.parse('$baseUrl/seguimientos?cursoId=$cursoId&actividadId=$actividadId');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar respuesta de seguimiento: ${response.statusCode}');
    }
  }

  @override
  Future<void> eliminarActividad(int cursoId, int actividadId) async {
    // Por ejemplo, asumiremos un endpoint DELETE específico para actividades
    // Si no existe, se podría derivar a eliminar la actividad desde el curso
    final url = Uri.parse('$baseUrl/cursos/$cursoId/actividades/$actividadId');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar actividad: ${response.statusCode}');
    }
  }

  @override
  Future<void> subirActividadCuestionario(
      int unidadId, ActividadCuestionario actividadCuestionarioSave, int cursoId) async {
    // Suponemos que el endpoint para esta operación es similar a:
    // POST http://localhost:8080/unidades/{unidadId}/actividades?cursoId={cursoId}
    final url = Uri.parse('$baseUrl/unidades/$unidadId/actividades?cursoId=$cursoId');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(actividadCuestionarioSave.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al subir actividad cuestionario: ${response.statusCode}');
    }
  }

  @override
  Future<void> subirSeguimientosActividadCuestionario(
      ActividadCuestionario actividadCuestionarioSave, int cursoId) async {
    // Suponiendo que la actualización de seguimiento es mediante PUT o POST
    // Por ejemplo, POST http://localhost:8080/seguimientos/actividad?cursoId={cursoId}
    final url = Uri.parse('$baseUrl/seguimientos/actividad?cursoId=$cursoId');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(actividadCuestionarioSave.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Error al subir seguimientos de actividad: ${response.statusCode}');
    }
  }
}