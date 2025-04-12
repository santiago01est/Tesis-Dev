import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/unidad.dart';
import '/domain/repository/unidad_repository.dart';

class UnidadHttpAdapter extends UnidadRepository {
  final String baseUrl = 'http://localhost:8080';

  @override
  Future<List<Unidad>> getUnidades(int idCurso) async {
    final url = Uri.parse('$baseUrl/unidades?cursoId=$idCurso');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Unidad.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener unidades: ${response.statusCode}');
    }
  }
}