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
      case 'gallina':
        chargeAnimation('objetos_animados/animales/',4, 32);
        break;
      case 'gallinaDerech':
        chargeAnimation('objetos_animados/animales/',4, 32);
        break;
      case 'gallinaV2':
        chargeAnimation('objetos_animados/animales/',4, 32);
        break;
      case 'patoDerech':
        chargeAnimation('objetos_animados/animales/',4, 32);
        break;
      case 'pato':
        chargeAnimation('objetos_animados/animales/',4, 32);
        break;
      case 'huevo':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'tim':
        chargeAnimation('objetos_animados/items/',8, 32);
      case 'bolsa':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'gemaAmarilla':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'gemaAzul':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'gemaRoja':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'gemaVerde':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'puerta':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'llave':
        chargeAnimation('objetos_animados/items/',4, 32);
        break;
      case 'antorchaV1':
        chargeAnimation2('objetos_animados/items/',6, 16, 32);
      case 'antorchaV2':
        chargeAnimation('objetos_animados/items/',6, 16);
        break;
      case 'antorchaV3':
        chargeAnimation('objetos_animados/items/',6, 16);
      case 'antorchaV4':
        chargeAnimation('objetos_animados/items/',4, 16);
        break;
      
    }
    debugMode= false;
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
  void chargeAnimation2(String path,int amount, double width, double height){
    animation= SpriteAnimation.fromFrameData(
      game.images.fromCache('$path$name.png'),
      SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: Vector2(width, height)
      )
    );
  }

  void itemDropRemove(){
    removeFromParent();
  }

}