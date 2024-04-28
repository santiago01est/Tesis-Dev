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
    List<String> elements = [
      'boycampoderecha.png', // 0
      'boycampofrente.png', // 1
      'boytemploderecha.png', // 2
      'pollitoUnidad0.jpg', // 3
      'cofre.png', // 4
      'llave 1.png', // 5
      'sacocafe.png', // 6
      'florUnidad0.png', // 7
      'gemaAmarilla.png', // 8
      'gemaAzul.png', // 9
      'gemaRoja.png', // 10
      'gemaVerde.png', // 11
      'gallinas.png', // 12
      'gallinaUnidad0.png', // 13
      'huevo.png', // 14
      'trigo.png', // 15
      'calabaza.png', // 16
      'pilar 1.png', // 17
      'pilarfuego.png', // 18
      'piedra 1.png', // 19
      'cajas.png', // 20
      'jarrones.png', // 21
      'abeja.png', // 22
      'gatoUnidad0.png', // 23
      'trigocosecha.png', // 24
      'arbol.png', // 25
      'arbolmandarino.png', // 26
      'canasta.png', // 27
      'cerdito.png', // 28
      'corralcerditos.png', // 29
    ];

    List<int>? elementsInfoBoard = actividadCuestionario.casillas;

    return SizedBox(
      width: actividadCuestionario.dimension! *
          110, // Tamaño del tablero (6 casillas * 110px por casilla)
      height: actividadCuestionario.dimension! *
          110, // Tamaño del tablero (6 casillas * 110px por casilla)
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              actividadCuestionario.dimension!, // 6 casillas por fila
        ),
        itemCount: actividadCuestionario.dimension! *
            actividadCuestionario.dimension!, // Total de casillas en el tablero
        itemBuilder: (context, index) {
          String casillarecurso = elementsInfoBoard![index] != -1
              ? 'assets/items/estudio/${elements[elementsInfoBoard[index]]}'
              : 'assets/whiteCasilla.png';
          return Container(
              width: 110, // Tamaño de cada casilla
              height: 110, // Tamaño de cada casilla
              decoration: BoxDecoration(
                //color del borde
                border: Border.all(color: Colors.black),
                // color de relleno
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(casillarecurso),
              ));
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
