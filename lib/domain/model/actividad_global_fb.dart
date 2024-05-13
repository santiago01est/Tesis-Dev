class ActividadGlobalFB {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  String? tipoActividad;
  List<int>? pesoRespuestas;
  List<int>? habilidades;
  //Computacional
  String? nombreArchivo;
  List<dynamic>? mejorCamino;
  List<dynamic>? mejorCamino2;
  int? initialState;
  // cuestionario
   int? dimension;
  List<int>? casillas;
  List<List<dynamic>>? respuestas;
  String? ejercicioImage;
  String? ejemploImage;
  String? pista;
  int? respuestaCorrecta;


  ActividadGlobalFB({
    this.id,
    this.nombre,
    this.descripcion ,
    this.estado ,
    this.tipoActividad ,
    this.pesoRespuestas ,
    this.habilidades ,
    this.nombreArchivo ,
    this.mejorCamino ,
    this.mejorCamino2 ,
    this.initialState ,
    this.dimension ,
    this.casillas ,
    this.respuestas ,
    this.ejercicioImage ,
    this.ejemploImage ,
    this.pista ,
    this.respuestaCorrecta  

  });

 

   // To Map
   factory ActividadGlobalFB.fromFirestore(Map<String, dynamic> json) {
    return ActividadGlobalFB(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      tipoActividad: json['tipoActividad'],
      pesoRespuestas: json['pesoRespuestas'] != null
          ? List<int>.from(json['pesoRespuestas'])
          : null,
      habilidades: json['habilidades'] != null
          ? List<int>.from(json['habilidades'])
          : null,
      nombreArchivo: json['nombreArchivo'],
      mejorCamino: json['mejorCamino'] != null ? List<dynamic>.from(json['mejorCamino']) : [],
      mejorCamino2: json['mejorCamino2'] != null ? List<dynamic>.from(json['mejorCamino2']) : [],
      initialState: json['initialState'],
      dimension: json['dimension'],
      casillas: json['casillas'] != null ? List<int>.from(json['casillas']) : null,
      respuestas: json['respuestas'] != null ? List<List<Object>>.from(json['respuestas']) : null,
      ejercicioImage: json['ejercicioImage'],
      ejemploImage: json['ejemploImage'],
      pista: json['pista'],
      respuestaCorrecta: json['respuestaCorrecta']
    );
  }

   Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (nombre != null) "nombre": nombre,
      if (descripcion != null) "descripcion": descripcion,
      if (estado != null) "estado": estado,
      if (tipoActividad != null) "tipoActividad": tipoActividad,
      if (pesoRespuestas != null) "pesoRespuestas": pesoRespuestas,
      if (habilidades != null) "habilidades": habilidades,
      if (nombreArchivo != null) "nombreArchivo": nombreArchivo,
      "mejorCamino": mejorCamino,
      if (mejorCamino2 != null) "mejorCamino2": mejorCamino2,
      if (initialState != null) "initialState": initialState,
      if (dimension != null) "dimension": dimension,
      if (casillas != null) "casillas": casillas,
      if (respuestas != null) "respuestas": respuestas,
      if (ejercicioImage != null) "ejercicioImage": ejercicioImage,
      if (ejemploImage != null) "ejemploImage": ejemploImage,
      if (pista != null) "pista": pista,
      if (respuestaCorrecta != null) "respuestaCorrecta": respuestaCorrecta
      
    };
  }


}