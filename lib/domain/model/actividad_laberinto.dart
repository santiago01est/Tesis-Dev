import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/game/player/player.dart';

class ActividadLaberinto extends Actividad {
  String? nombreArchivo;
  List<dynamic>? mejorCamino;
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
      super.pista,
      super.unidadId,
      this.nombreArchivo,
      this.mejorCamino,
      this.mejorCamino2 = const [],
      this.initialState});

  // To Map
  factory ActividadLaberinto.fromFirestore(Map<String, dynamic> data) {
    return ActividadLaberinto(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      tipoActividad: data['tipoActividad'],
      pesoRespuestas: data['pesoRespuestas'],
      habilidades: data['habilidades'],
      pista: data['pista'],
      unidadId: data['unidadId'],
      nombreArchivo: data['nombreArchivo'],
      mejorCamino: data['mejorCamino'] != null
          ? List<dynamic>.from(data['mejorCamino'])
          : [],
      mejorCamino2: data['mejorCamino2'] != null
          ? List<dynamic>.from(data['mejorCamino2'])
          : [],
      initialState: data['initialState'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "estado": estado,
      "tipoActividad": tipoActividad,
      "pesoRespuestas": pesoRespuestas,
      "habilidades": habilidades,
      "pista": pista,
      "unidadId": unidadId,
      "nombreArchivo": nombreArchivo,
      "mejorCamino": mejorCamino,
      "mejorCamino2": mejorCamino2,
      "initialState": initialState,
    };
  }
}
