import 'dart:async';

import 'package:dev_tesis/game/components/collision_block.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../components/animation_object.dart';

class Level extends World with HasGameRef<GameActivity>{

  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks=[];


  @override
  FutureOr<void> onLoad() async{
    const RUTA_DECORACION_CAMPO= 'mapa/decoracion-suelo/unidad1-Campo/';
    const RUTA_OBJETOS_UP_DOWN= 'mapa/objetos-UpAndDown/';
    const RUTA_SUELO_CAMPO= 'mapa/suelo/unidad1-Campo/';
    
    level= await TiledComponent.load('Nivel01-renovado.tmx', Vector2(16, 16));
    
    add(level);
    final sueloMap= level.tileMap.getLayer<ObjectGroup>('Suelo');
    if (sueloMap != null && sueloMap.class_== 'campo'){
      for(final itemMap in sueloMap.objects){
        final image= loadImage(itemMap, RUTA_SUELO_CAMPO, Vector2(160, 160));
            image.priority=0;
            add(image);

        /* switch(itemMap.class_){
          case 'esquina':
            final image= loadImage(itemMap, RUTA_SUELO_CAMPO);
            image.priority=-1;
            add(image);
            break;
          case 'borde':
            final image= loadImage(itemMap, RUTA_SUELO_CAMPO);
            image.priority=-1;
            add(image);
            break;
          case 'terreno':
            final image= loadImage(itemMap, RUTA_SUELO_CAMPO);
            image.priority=-1;
            add(image);
            break;
          default:
        } */
      }
    }
    final borderMap= level.tileMap.getLayer<ObjectGroup>('Borde');
    if (borderMap != null && borderMap.class_== 'campo'){
      for(final itemMap in borderMap.objects){
        final image= loadImage(itemMap, RUTA_SUELO_CAMPO, Vector2(192, 176));
            image.priority=0;
            add(image);
      }
    }

    final sueloZ0Map= level.tileMap.getLayer<ObjectGroup>('Suelo-z0');
    if (sueloZ0Map != null && sueloZ0Map.class_== 'campo'){
      for(final itemMap in sueloZ0Map.objects){
        final image= loadImage(itemMap, RUTA_SUELO_CAMPO);
            image.priority=1;
            add(image);
      }
    }
    final sueloDecoracionMap= level.tileMap.getLayer<ObjectGroup>('Suelo-decoracion');
    if (sueloDecoracionMap != null && sueloDecoracionMap.class_== 'campo'){
      for(final itemMap in sueloDecoracionMap.objects){
        final image= loadImage(itemMap, RUTA_DECORACION_CAMPO);
            image.priority=2;
            add(image);
      }
    }

    final decoracionDownMap= level.tileMap.getLayer<ObjectGroup>('Decoracion-down');
    if (decoracionDownMap != null && decoracionDownMap.class_== 'campo'){
      for(final itemMap in decoracionDownMap.objects){
        switch(itemMap.class_){
          case '32x16':
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN, Vector2(32, 16));
            image.priority=2;
            add(image);
            break;
          case '16x32':
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN, Vector2(16, 32));
            image.priority=2;
            add(image);
            break;
          default:
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN);
            image.priority=2;
            add(image);
            break;
        }
        
      }
    }

    final decoracionDownZ1Map= level.tileMap.getLayer<ObjectGroup>('Decoracion-down-z1');
    if (decoracionDownZ1Map != null && decoracionDownZ1Map.class_== 'campo'){
      for(final itemMap in decoracionDownZ1Map.objects){
        switch(itemMap.class_){
          case '32x32':
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN, Vector2(32, 32));
            image.priority=3;
            add(image);
            break;
          case '48x48':
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN, Vector2(48, 48));
            image.priority=3;
            add(image);
            break;
          default:
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN);
            image.priority=3;
            add(image);
            break;
        }
        
      }
    }

    final animalesLayer= level.tileMap.getLayer<ObjectGroup>('Animales');
    if (animalesLayer != null && animalesLayer.class_== 'campo'){
      for(final object in animalesLayer.objects){
        switch(object.class_){
          case 'animal':
            final animationObject= Animation_Object(
              Vector2(object.x, object.y), 
              Vector2(object.width, object.height),
              object.name
            );
            animationObject.priority=4;
            add(animationObject);
            break;
          /* case 'Up-Object':
            final image= loadImage(object, RUTA_OBJETOS_UP);
            image.priority=3;
            add(image);
            break;
          case 'Down-Object':
            final image= loadImage(object, RUTA_OBJETOS);
            image.priority=1;
            add(image);
            break; */
        }
      }
    }
    final spawnPointsLayer= level.tileMap.getLayer<ObjectGroup>('Jugador');
    if (spawnPointsLayer != null){
      for(final spawnPoint in spawnPointsLayer.objects){
        player.position= Vector2(spawnPoint.x, spawnPoint.y);
            player.priority= 5;
            add(player);
      }
    }

    final decoracionUpMap= level.tileMap.getLayer<ObjectGroup>('Decoracion-up');
    if (decoracionUpMap != null && decoracionUpMap.class_== 'campo'){
      for(final itemMap in decoracionUpMap.objects){
        switch(itemMap.class_){
          case '32x16':
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN, Vector2(32, 16));
            image.priority=6;
            add(image);
            break;
          default:
            final image= loadImage(itemMap, RUTA_OBJETOS_UP_DOWN);
            image.priority=6;
            add(image);
            break;
        }
        
      }
    }
    
    final collisionsLayer= level.tileMap.getLayer<ObjectGroup>('Colisiones');
    if (collisionsLayer != null){
      for(final collision in collisionsLayer.objects){
        final block= CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              type: collision.name,
            );
            collisionBlocks.add(block);
            add(block);
          /* case 'Meta':
            final block= CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              type: collision.name,
            );
            collisionBlocks.add(block);
            add(block);
            break; */
      }
    }

    player.collisionBlocks= collisionBlocks;
    return super.onLoad();
  }

  SpriteComponent loadImage(TiledObject object, String ruta, [Vector2? size]) {
    String name= object.name;
    print('$ruta$name.png');
    var image=SpriteComponent.fromImage(
              game.images.fromCache('$ruta$name.png'),
              position: Vector2(object.x, object.y),
              size: size ?? Vector2(16, 16),
    );
    return image;
  }
}