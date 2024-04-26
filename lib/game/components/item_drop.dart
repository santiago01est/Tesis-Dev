import 'dart:async';

import 'package:dev_tesis/game/game_activity.dart';
import 'package:flame/components.dart';

class ItemDrop extends SpriteAnimationComponent with HasGameRef<GameActivity>{
  ItemDrop(position, size, this.name) : super(position: position, size: size);

  final double stepTime= 1/6;
  final String name;

  @override
  FutureOr<void> onLoad() {

    chargeAnimation('objetos_animados/items/',4, 32);


    debugMode = true;
    return super.onLoad();
  }

  void chargeAnimation(String path,int amount, double size){
    animation= SpriteAnimation.fromFrameData(
      game.images.fromCache('$path$name.png'),
      SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: Vector2.all(size)
      )
    );
  }

  void itemDropAction(){
    removeFromParent();
  }
}
