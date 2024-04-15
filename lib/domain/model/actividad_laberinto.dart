import 'package:dev_tesis/domain/model/actividad.dart';

class ActividadLaberinto extends Actividad{

  String? nombreArchivo;

  ActividadLaberinto({
    super.id,
       super.nombre,
       super.descripcion,
       super.estado,
       super.tipoActividad,
       super.pesoRespuestas,
        this.nombreArchivo
  });

  
  }
