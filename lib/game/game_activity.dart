import 'dart:async';
import 'dart:ui';

import 'package:dev_tesis/game/levels/level.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class GameActivity extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection{
  final String nombretmx;
  GameActivity(this.nombretmx);
  @override
  Color backgroundColor()=> const Color.fromARGB(0, 0, 0, 0);
  late final CameraComponent cam;
  Player player= Player();
  
  @override
  FutureOr<void> onLoad() async{

    //Carga todas las imagenes en cache
    await images.loadAllImages();
    final world = Level(levelName: nombretmx, player: player);
    cam = CameraComponent.withFixedResolution(world: world, width: 192, height: 192);
    cam.viewfinder.anchor= Anchor.topLeft;
    
    addAll([cam, world]);
    return super.onLoad();
  }

  /* asignarRespuesta(int respuesta){
    player.asignarRespuesta(respuesta);
  } */

}