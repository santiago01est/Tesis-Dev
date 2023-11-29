//clase con un metodo que retorna el array de rutas de las imagenes

import 'dart:math';

class RutasImagenes {
  static List<String> getRutasPortadas() {
    return [
      'assets/FondoHome.png',
      'assets/FondoInicio.png',
      'assets/FondoIniciosesion.png',
    ];
  }

  static List<String> getRutasAvatares() {
    return [
      "assets/items/perico_mascota.png",
      "assets/gato.png",
      "assets/chico.png",
      "assets/chica.png",
      "assets/bus.png",
      "assets/home.png",
    ];
  }

  //metodo que retorna una ruta aleatoriamente

  static String getRandomRuta() {
    List<String> rutas = getRutasAvatares();
    return rutas[Random().nextInt(rutas.length)];
  }
}
