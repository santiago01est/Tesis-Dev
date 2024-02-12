// Definición de una casilla del tablero
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/casilla.dart';

import 'package:flutter/material.dart';

class TableroCuestionario extends StatelessWidget {
  final ActividadCuestionario actividadCuestionario;
  const TableroCuestionario({Key? key, required this.actividadCuestionario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: actividadCuestionario.dimension *
          90, // Tamaño del tablero (6 casillas * 90px por casilla)
      height: actividadCuestionario.dimension *
          90, // Tamaño del tablero (6 casillas * 90px por casilla)
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              actividadCuestionario.dimension, // 6 casillas por fila
        ),
        itemCount: actividadCuestionario.dimension *
            actividadCuestionario.dimension, // Total de casillas en el tablero
        itemBuilder: (context, index) {
          final casilla = obtenerCasilla(index, actividadCuestionario.casillas);
          return Container(
            width: 90, // Tamaño de cada casilla
            height: 90, // Tamaño de cada casilla
            decoration: BoxDecoration(
              //color del borde
              border: Border.all(color: Colors.black),
              // color de relleno
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Image(
              image: casilla != null
                  ? AssetImage(casilla.recurso)
                  : const AssetImage(
                      'assets/whiteCasilla.png'), // Fondo de la casilla
              //fit: BoxFit.fill, // Ajuste para cubrir el contenedor
            ),
          );
        },
      ),
    );
  }
}

//metodo que retorna el recurso de una casilla segun su posicion y si no hay casilla con esa posicio retorna ""
Casilla? obtenerCasilla(int index, List<Casilla> casillas) {
  //recorre la lista de casillas y si encuentra una casilla con esa posicion retorna el recurso de esa casilla
  for (var i = 0; i < casillas.length; i++) {
    for (var j = 0; j < casillas[i].numeroCasillas.length; j++) {
      if (casillas[i].numeroCasillas[j] == index) {
        return casillas[i];
      }
    }
  }
  return null;
}
