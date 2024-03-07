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
<<<<<<< HEAD
    final world = Level(levelName: nombretmx, player: player);
=======
    final world = Level(levelName: 'Nivel01-renovado', player: player);
>>>>>>> 6fe767d462f097363ef2e1fa82e9a4fab4ed1d6b
    cam = CameraComponent.withFixedResolution(world: world, width: 192, height: 192);
    cam.viewfinder.anchor= Anchor.topLeft;
    
    addAll([cam, world]);
    return super.onLoad();
  }

}