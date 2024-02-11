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
    const RUTA_DECORACION= 'map/decoracion/';
    const RUTA_OBJETOS= 'map/objetos/';
    const RUTA_OBJETOS_UP= 'map/objetos_up/';
    const RUTA_SUELO= 'map/suelo/';
    
    level= await TiledComponent.load('Level-02.tmx', Vector2(16, 16));
    
    add(level);
    final levelMap= level.tileMap.getLayer<ObjectGroup>('Map');
    if (levelMap != null){
      for(final itemMap in levelMap.objects){
        switch(itemMap.class_){
          case 'esquina-superior-izq':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'esquina-superior-derech':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'esquina-inferior-izq':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'esquina-inferior-derech':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'borde-izq':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'borde-derech':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'borde-superior':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'borde-inferior':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          case 'suelo':
            final image= loadImage(itemMap, RUTA_SUELO);
            image.priority=-1;
            add(image);
            break;
          
          default:
        }
      }
    }
    final mapDecoration= level.tileMap.getLayer<ObjectGroup>('Decoration');

    if (mapDecoration != null){
      for(final decoration in mapDecoration.objects){
        switch(decoration.class_){
          case 'hojas-1':
            final image= loadImage(decoration, RUTA_DECORACION);
            image.priority=0;
            add(image);
            break;
          case 'flor-1':
            final image= loadImage(decoration, RUTA_DECORACION);
            image.priority=0;
            add(image);
            break;
          case 'flor-2':
            final image= loadImage(decoration, RUTA_DECORACION);
            image.priority=0;
            add(image);
            break;
          default:
        }
      }
    }

    final objectsLayer= level.tileMap.getLayer<ObjectGroup>('Objects');
    if (objectsLayer != null){
      for(final object in objectsLayer.objects){
        switch(object.class_){
          case 'Animation_Object':
            final animationObject= Animation_Object(
              Vector2(object.x, object.y), 
              Vector2(object.width, object.height),
              object.name
            );
            animationObject.priority=2;
            add(animationObject);
            break;
          case 'Up-Object':
            final image= loadImage(object, RUTA_OBJETOS_UP);
            image.priority=3;
            add(image);
            break;
          case 'Down-Object':
            final image= loadImage(object, RUTA_OBJETOS);
            image.priority=1;
            add(image);
            break;
        }
      }
    }
    final spawnPointsLayer= level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    if (spawnPointsLayer != null){
      for(final spawnPoint in spawnPointsLayer.objects){
        switch(spawnPoint.class_){
          case 'Player':
            player.position= Vector2(spawnPoint.x, spawnPoint.y);
            player.priority= 4;
            add(player);
            break;
          
          default:
        }
      }
    }
    
    final collisionsLayer= level.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionsLayer != null){
      for(final collision in collisionsLayer.objects){
        switch(collision.class_){
          case 'Wall':
            final block= CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              type: collision.name,
            );
            collisionBlocks.add(block);
            add(block);
            break;
          case 'Arrival_point':
            final block= CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              type: collision.name,
            );
            collisionBlocks.add(block);
            add(block);
            break;
        }
      }
    }

    player.collisionBlocks= collisionBlocks;
    return super.onLoad();
  }

  SpriteComponent loadImage(TiledObject object, String ruta){
    String name= object.name;
    var image=SpriteComponent.fromImage(
              game.images.fromCache('$ruta$name.png'),
              position: Vector2(object.x, object.y),
              size: Vector2(16, 16)
    );
    return image;
  }
}