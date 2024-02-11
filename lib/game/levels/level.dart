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
    const RUTA_DECORACION_CAMPO= 'mapa/decoracion/unidad1-Campo/';
    const RUTA_OBJETOS= 'mapa/objetos/';
    const RUTA_OBJETOS_UP= 'mapa/objetos_up/';
    const RUTA_SUELO_CAMPO= 'mapa/suelo/unidad1-Campo/';
    
    level= await TiledComponent.load('Nivel01.tmx', Vector2(16, 16));
    
    add(level);
    final levelMap= level.tileMap.getLayer<ObjectGroup>('SueloBase');
    if (levelMap != null && levelMap.class_== 'campo'){
      for(final itemMap in levelMap.objects){
        final image= loadImage(itemMap, RUTA_SUELO_CAMPO);
            image.priority=-1;
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
    final mapDecoration= level.tileMap.getLayer<ObjectGroup>('DecoracionZ0');
    if (mapDecoration != null && mapDecoration.class_== 'campo'){
      for(final decoration in mapDecoration.objects){
        switch(decoration.class_){
          case 'decoracion-z0':
            final image= loadImage(decoration, RUTA_DECORACION_CAMPO);
            image.priority=0;
            add(image);
            break;
          default:
        }
      }
    }

    final objectsLayer= level.tileMap.getLayer<ObjectGroup>('Objetos');
    if (objectsLayer != null && objectsLayer.class_== 'campo'){
      for(final object in objectsLayer.objects){
        switch(object.class_){
          case 'objeto-animado':
            final animationObject= Animation_Object(
              Vector2(object.x, object.y), 
              Vector2(object.width, object.height),
              object.name
            );
            animationObject.priority=2;
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
        switch(spawnPoint.class_){
          case 'jugador':
            player.position= Vector2(spawnPoint.x, spawnPoint.y);
            player.priority= 4;
            add(player);
            break;
          
          default:
        }
      }
    }
    
    final collisionsLayer= level.tileMap.getLayer<ObjectGroup>('Colisiones');
    if (collisionsLayer != null){
      for(final collision in collisionsLayer.objects){
        switch(collision.class_){
          case 'Collision':
            final block= CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              type: collision.name,
            );
            collisionBlocks.add(block);
            add(block);
            break;
          default:
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
    }

    player.collisionBlocks= collisionBlocks;
    return super.onLoad();
  }

  SpriteComponent loadImage(TiledObject object, String ruta){
    String name= object.name;
    print('$ruta$name.png');
    var image=SpriteComponent.fromImage(
              game.images.fromCache('$ruta$name.png'),
              position: Vector2(object.x, object.y),
              size: Vector2(16, 16)
    );
    return image;
  }
}