import 'dart:async';

import 'package:dev_tesis/game/game_activity.dart';
import 'package:flame/components.dart';

class Animation_Object extends SpriteAnimationComponent with HasGameRef<GameActivity>{
  
  Animation_Object(position, size, this.name) : super(position: position, size: size);

  final double stepTime= 1/6;
  final String name;

  @override
  FutureOr<void> onLoad() {
  
    switch(name){
      case 'chickens':
        chargeAnimation(4, 32);
        break;
    }
    debugMode= false;
    return super.onLoad();
  }

  void chargeAnimation(int amount, double size){
    animation= SpriteAnimation.fromFrameData(
      game.images.fromCache('$name.png'),
      SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: Vector2.all(size)
      )
    );
  }

}