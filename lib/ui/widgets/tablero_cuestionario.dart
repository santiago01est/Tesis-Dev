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
    return Container(
      width: actividadCuestionario.dimension *
          60, // Tamaño del tablero (6 casillas * 60px por casilla)
      height: actividadCuestionario.dimension *
          60, // Tamaño del tablero (6 casillas * 60px por casilla)
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
            width: 60, // Tamaño de cada casilla
            height: 60, // Tamaño de cada casilla
            decoration: BoxDecoration(
              //color del borde
              border: Border.all(color: Colors.black),
              image: DecorationImage(
                image: casilla != null
                    ? AssetImage(casilla.recurso)
                    : const AssetImage(
                        'assets/whiteCasilla.png'), // Fondo de la casilla
                fit: BoxFit.cover,
              ),
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
    if (casillas[i].numeroCasilla == index) {
      return casillas[i];
    }
  }
  return null;
}
