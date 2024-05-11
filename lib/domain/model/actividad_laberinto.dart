import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/game/player/player.dart';

class ActividadLaberinto extends Actividad {
  String? nombreArchivo;
  List<dynamic> mejorCamino;
  List<dynamic>? mejorCamino2;
  int? initialState;
  

 

  ActividadLaberinto(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.tipoActividad,
      super.pesoRespuestas,
      super.habilidades,
      this.nombreArchivo,
      required this.mejorCamino,
      this.mejorCamino2 = const [],
       this.initialState});

      @override
        Map<String, dynamic> toMap() {
    return {
      ...super.toMap(), // Llama al método toMap de la clase madre
      'nombreArchivo': nombreArchivo,
      'mejorCamino': mejorCamino,
      'mejorCamino2': mejorCamino2,
    };
  }

  factory ActividadLaberinto.fromJson(Map<String, dynamic> json) {
    return ActividadLaberinto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      tipoActividad: json['tipoActividad'],
      pesoRespuestas: json['pesoRespuestas'],
      habilidades: json['habilidades'],
      nombreArchivo: json['nombreArchivo'],
      mejorCamino: json['mejorCamino'] != null ? List<dynamic>.from(json['mejorCamino']) : [],
      mejorCamino2: json['mejorCamino2'] != null ? List<dynamic>.from(json['mejorCamino2']) : [],
      initialState: json['initialState'],
    );
  }
}
