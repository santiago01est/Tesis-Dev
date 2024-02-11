//clase con un metodo que retorna el array de rutas de las imagenes

import 'dart:math';

class RutasImagenes {
  static List<String> getRutasPortadas() {
    return [
      'assets/fondos/FondoHome.png',
      'assets/fondos/FondoInicio.png',
      'assets/fondos/FondoIniciosesion.png',
    ];
  }

  static List<String> getRutasAvatares() {
    return [
      "assets/avatares/perico_avatar.png",
      "assets/avatares/gato_avatar.png",
      "assets/avatares/chiguiro_avatar.png",
      "assets/avatares/acordeon_avatar.png",
      "assets/avatares/aguila_avatar.png",
      "assets/avatares/burro_avatar.png",
      "assets/avatares/cafe_avatar.png",
      "assets/avatares/cultivo_avatar.png",
      "assets/avatares/cuy_avatar.png",
      "assets/avatares/finca_avatar.png",
      "assets/avatares/granjero_avatar.png",
      "assets/avatares/guacamaya_avatar.png",
      "assets/avatares/indio_avatar.png",
      "assets/avatares/jeep_avatar.png",
      "assets/avatares/mariposa_avatar.png",
      "assets/avatares/mujergranjera_avatar.png",
      "assets/avatares/orquidea_avatar.png",
      "assets/avatares/osoanteojos_avatar.png",
      "assets/avatares/palmaCera_avatar.png",
      "assets/avatares/pollitos_avatar.png",
    ];
  }

  //metodo que retorna una ruta aleatoriamente

  static String getRandomRuta() {
    List<String> rutas = getRutasAvatares();
    return rutas[Random().nextInt(rutas.length)];
  }
}
