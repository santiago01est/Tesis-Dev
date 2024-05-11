import 'dart:async';

import 'package:dev_tesis/game/components/animation_object.dart';
import 'package:dev_tesis/game/components/collision_block.dart';
import 'package:dev_tesis/game/components/custom_hitbox.dart';
import 'package:dev_tesis/game/components/item_drop.dart';
import 'package:dev_tesis/game/utilities/player_utils.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/game/utilities/qualifying_profiles.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';

enum PlayerState {
  idleR,
  idleL,
  idleU,
  idleD,
  runningR,
  runningL,
  runningU,
  runningD,
  deathR,
  deathL,
  deathU,
  deathD,
  victory,
  itemDrop,
  trampa,
  trampaIdle
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<GameActivity>, KeyboardHandler {
  late List<String> movementInstructions;

  Player({position, priority}) : super(position: position, priority: priority);

  int currentInstructionIndex = 0;
  late final SpriteAnimation idleRightAnimation;
  late final SpriteAnimation idleLeftAnimation;
  late final SpriteAnimation idleUpAnimation;
  late final SpriteAnimation idleDownAnimation;
  late final SpriteAnimation runningRightAnimation;
  late final SpriteAnimation runningLeftAnimation;
  late final SpriteAnimation runningUpAnimation;
  late final SpriteAnimation runningDownAnimation;
  late final SpriteAnimation downDeathAnimation;
  late final SpriteAnimation rightDeathAnimation;
  late final SpriteAnimation leftDeathAnimation;
  late final SpriteAnimation upDeathAnimation;
  late final SpriteAnimation victoryAnimation;
  late final SpriteAnimation itemDropAnimation;
  late final SpriteAnimation trampaAnimation;
  late final SpriteAnimation trampaIdleAnimation;

  late final double startPositionX;
  late final double startPositionY;

  late PlayerState? initialState;

  final double stepTimeIdle = 1 / 6;
  final double stepTimeRun = 1 / 12;

  List<CollisionBlock> collisionBlocks = [];
  Animation_Object? itemDropComponent;
  Animation_Object? itemDropFalsoComponent;
  Animation_Object? victoryItemComponent;
  Animation_Object? puertaComponent;
  CollisionBlock itemDrop = CollisionBlock();
  CollisionBlock itemDropFalso = CollisionBlock();
  CollisionBlock victoryItem = CollisionBlock();
  CollisionBlock puerta = CollisionBlock();

  ///Salidas de la escalera
  //? Verde
  double evPositionX = 40;
  double evPositionY = 68;
  //? Roja
  double erPositionX = 8;
  double erPositionY = 132;

  bool calloEnLaTrampa = false;
  Map<String, bool> playerRespuesta = {
    "Llego a la meta": false,
    "Mejor camino": false,
    "No choco con obstaculos": true,
    "Recogio el objeto/item": false,
  };

  /*
  * hitbox: Es usado en el metodo onLoad para ajustar el hitbox del jugador en el juego,
  * permitiendolo posicionar de forma correcta y que las collisiones funcionen de acuerdo a un juego
  * hecho en medidas de 16x16 pixeles.
  **/
  final CustomHitbox hitbox =
      CustomHitbox(offSetX: 8, offSetY: 12, width: 16, height: 16);

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    add(RectangleHitbox(
        position: Vector2(hitbox.offSetX, hitbox.offSetY),
        size: Vector2(hitbox.width, hitbox.height)));
    startPositionX = position.x;
    startPositionY = position.y;
    debugMode = false;
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleRightAnimation =
        _spriteAnimationsGenerator('right', 'idle-', 6, stepTimeIdle);
    idleLeftAnimation =
        _spriteAnimationsGenerator('left', 'idle-', 6, stepTimeIdle);
    idleUpAnimation =
        _spriteAnimationsGenerator('up', 'idle-', 6, stepTimeIdle);
    idleDownAnimation =
        _spriteAnimationsGenerator('down', 'idle-', 6, stepTimeIdle);
    runningRightAnimation =
        _spriteAnimationsGenerator('right', 'run-', 6, stepTimeRun);
    runningLeftAnimation =
        _spriteAnimationsGenerator('left', 'run-', 6, stepTimeRun);
    runningUpAnimation =
        _spriteAnimationsGenerator('up', 'run-', 6, stepTimeRun);
    runningDownAnimation =
        _spriteAnimationsGenerator('down', 'run-', 6, stepTimeRun);
    downDeathAnimation =
        _spriteAnimationsGenerator('down', 'death-', 6, stepTimeIdle);
    rightDeathAnimation =
        _spriteAnimationsGenerator('right', 'death-', 6, stepTimeIdle);
    leftDeathAnimation =
        _spriteAnimationsGenerator('left', 'death-', 6, stepTimeIdle);
    upDeathAnimation =
        _spriteAnimationsGenerator('up', 'death-', 6, stepTimeIdle);
    victoryAnimation =
        _spriteAnimationsGenerator('', 'victory2', 4, stepTimeIdle);
    itemDropAnimation =
        _spriteAnimationsGenerator('', 'item-drop', 8, stepTimeIdle);
    trampaAnimation =
        _spriteAnimationsGenerator('', 'trampa', 14, stepTimeIdle);
    trampaIdleAnimation =
        _spriteAnimationsGenerator('', 'trampaIdle', 1, stepTimeIdle);

    animations = {
      PlayerState.idleR: idleRightAnimation,
      PlayerState.idleL: idleLeftAnimation,
      PlayerState.idleU: idleUpAnimation,
      PlayerState.idleD: idleDownAnimation,
      PlayerState.runningR: runningRightAnimation,
      PlayerState.runningL: runningLeftAnimation,
      PlayerState.runningU: runningUpAnimation,
      PlayerState.runningD: runningDownAnimation,
      PlayerState.deathR: rightDeathAnimation,
      PlayerState.deathL: leftDeathAnimation,
      PlayerState.deathU: upDeathAnimation,
      PlayerState.deathD: downDeathAnimation,
      PlayerState.victory: victoryAnimation,
      PlayerState.itemDrop: itemDropAnimation,
      PlayerState.trampa: trampaAnimation,
      PlayerState.trampaIdle: trampaIdleAnimation
    };
    current = initialState;
  }

  void chargeInitialState(int initialStateEnum) {
    initialState = PlayerState.values[initialStateEnum];
  }


  /*
  * processMovementInstructions: metodo que se encarga de procesar las instrucciones
  * de movimiento del jugador pasadas desde la interfaz del nivel y retornar un boolean
  * que indica si se llego a la meta o no.
  **/
  Future<bool> processMovementInstructions() async {
    if (itemDropComponent == null) {
      playerRespuesta["Recogio el objeto/item"] = true;
    }
    // ignore: unnecessary_null_comparison
    if (movementInstructions != null || movementInstructions.isNotEmpty) {
      bool ejecucionRespuesta = await _executeInstructions();
      print(playerRespuesta);
      return ejecucionRespuesta;
    }
    return false;
  }

  Future<int> processMovementInstructionsResponse(
      List respuestaGeneral, List mejorCamino, List? mejorCamino2) async {
    if (itemDropComponent == null) {
      playerRespuesta["Recogio el objeto/item"] = true;
    }
    // ignore: unnecessary_null_comparison
    if (movementInstructions != null) {
      await _executeInstructions();
      respuestaGeneral.removeWhere(
          (element) => element is String && element.contains('recoger'));
      if ((respuestaGeneral.toString() == mejorCamino.toString()) ||
          (respuestaGeneral.toString() == mejorCamino2.toString())) {
        print('Entramos ^^');
        playerRespuesta["Mejor camino"] = true;
      } else {
        playerRespuesta["Mejor camino"] = false;
      }
      print(playerRespuesta);
      return generalProfile(playerRespuesta);
    }

    return generalProfile(playerRespuesta);
  }

  _executeInstructions() async {
    var i = 0;
    for (var movement in movementInstructions) {
      if (calloEnLaTrampa == false) {
        i++;
        final instruction = movement;
        i == movementInstructions.length
            ? await _executeInstruction(instruction, true)
            : await _executeInstruction(instruction, false);
      } else {
        break;
      }
    }
  }

  _executeInstruction(String instruction, bool lastInstruction) async {
    String finalInstruction = '';
    if (instruction == 'avanzar') {
      if (current == PlayerState.idleR) finalInstruction = 'derecha';
      if (current == PlayerState.idleL) finalInstruction = 'izquierda';
      if (current == PlayerState.idleU) finalInstruction = 'arriba';
      if (current == PlayerState.idleD) finalInstruction = 'abajo';
    }

    if (instruction == 'recoger') {
      finalInstruction = 'recoger';
    }

    if (instruction == 'giroDeDerecha') {
      await Future.delayed(const Duration(milliseconds: 333));
      if (current == PlayerState.idleR) {
        current = PlayerState.idleD;
      } else if (current == PlayerState.idleD) {
        current = PlayerState.idleL;
      } else if (current == PlayerState.idleL) {
        current = PlayerState.idleU;
      } else if (current == PlayerState.idleU) {
        current = PlayerState.idleR;
      }
      await Future.delayed(const Duration(milliseconds: 333));
      return;
    }

    if (instruction == 'giroDeIzquierda') {
      await Future.delayed(const Duration(milliseconds: 333));
      if (current == PlayerState.idleL) {
        current = PlayerState.idleD;
      } else if (current == PlayerState.idleD) {
        current = PlayerState.idleR;
      } else if (current == PlayerState.idleR) {
        current = PlayerState.idleU;
      } else if (current == PlayerState.idleU) {
        current = PlayerState.idleL;
      }
      await Future.delayed(const Duration(milliseconds: 333));
      return;
    }

    final block = _checkNextBlockForCollision(finalInstruction);

    print(block.type);
    if (block.type == 'err') {
      print(finalInstruction);
      // ignore: avoid_print
      print('Hubo un error');
    }
    if (block.type == 'item-drop') {
      itemDrop = block;
    }
    if (block.type == 'itemFalso') {
      itemDropFalso = block;
    }
    if (block.type == 'meta-item') {
      victoryItem = block;
    }
    if (block.type == 'puerta') {
      puerta = block;
    }
    if (itemDrop.type == 'item-drop' &&
        finalInstruction == 'recoger' &&
        playerRespuesta["Recogio el objeto/item"] == false) {
      PlayerState currentBeforeDrop = current;
      priority = 7;
      parent!.remove(itemDropComponent!);
      current = PlayerState.itemDrop;
      await Future.delayed(const Duration(milliseconds: 1360));
      priority = 5;
      playerRespuesta["Recogio el objeto/item"] = true;
      current = currentBeforeDrop;
    }
    if (itemDropFalso.type == 'itemFalso' && finalInstruction == 'recoger') {
      priority = 7;
      parent!.remove(itemDropFalsoComponent!);
      current = PlayerState.itemDrop;
      await Future.delayed(const Duration(milliseconds: 1310));
      priority = 5;
      current = PlayerState.trampa;
      await Future.delayed(const Duration(milliseconds: 2310));
      current = PlayerState.trampaIdle;
      calloEnLaTrampa = true;
      return;
    }
    if (victoryItem.type == 'meta-item' && finalInstruction == 'recoger') {
      priority = 7;
      parent!.remove(victoryItemComponent!);
      current = PlayerState.itemDrop;
      await Future.delayed(const Duration(milliseconds: 1360));
      priority = 5;
      current = PlayerState.victory;
      playerRespuesta["Llego a la meta"] = true;
      return;
    }
    if (finalInstruction == 'derecha') {
      return _executeDisplacement(block, lastInstruction, PlayerState.runningR,
          PlayerState.idleR, Vector2(16, 0));
    }
    if (finalInstruction == 'izquierda') {
      return _executeDisplacement(block, lastInstruction, PlayerState.runningL,
          PlayerState.idleL, Vector2(-16, 0));
    }
    if (finalInstruction == 'arriba') {
      return _executeDisplacement(block, lastInstruction, PlayerState.runningU,
          PlayerState.idleU, Vector2(0, -16));
    }
    if (finalInstruction == 'abajo') {
      return _executeDisplacement(block, lastInstruction, PlayerState.runningD,
          PlayerState.idleD, Vector2(0, 16));
    }

    return;
  }

  _executeDisplacement(CollisionBlock block, bool lastInstruction,
      PlayerState movementState, PlayerState idleState, Vector2 movementVector,
      [bool? recoger = false]) async {
    if (block.type == 'null' ||
        block.type == 'item-drop' ||
        block.type == 'itemFalso' ||
        block.type == 'meta-item' ||
        (block.type == 'puerta' && playerRespuesta["Recogio el objeto/item"] == true) ||
        block.type == 'teleportV' ||
        block.type == 'teleportR') {
      current = movementState;
      add(MoveByEffect(movementVector, EffectController(duration: 0.51)));
      await Future.delayed(const Duration(milliseconds: 510));
      current = idleState;
      if (block.type == 'teleportV') {
        position.x = evPositionX;
        position.y = evPositionY;
      } else if (block.type == 'teleportR') {
        position.x = erPositionX;
        position.y = erPositionY;
      }
    } else if (block.type == 'meta' && lastInstruction == true) {
      print(lastInstruction);
      current = movementState;
      add(MoveByEffect(movementVector, EffectController(duration: 0.51)));
      await Future.delayed(const Duration(milliseconds: 510));
      current = PlayerState.victory;
      playerRespuesta["Llego a la meta"] = true;
      return;
    } else if (block.type == 'colision' || (block.type == 'puerta' && playerRespuesta["Recogio el objeto/item"] == false))  {
      playerRespuesta["No choco con obstaculos"] = false;
    }
    currentInstructionIndex += 1;
    return;
  }

  /*
  *  _checkNextBlockForCollision: Metodo para la identificacion de colisiones
  * */
  CollisionBlock _checkNextBlockForCollision(String direction) {
    final playerX = playerXPosition(this);
    final playerY = playerYPosition(this);
    List<CollisionBlock> sortedCollidables = collisionBlocks.toList()
      ..sort((a, b) {
        int distanceComparison =
            a.distanceTo(this).compareTo(b.distanceTo(this));

        if (distanceComparison == 0) {
          String directionA = a.getDirectionRelativeToPlayer(this);
          String directionB = b.getDirectionRelativeToPlayer(this);

          if (direction == directionA && direction != directionB) {
            return -1; // Bloque A tiene prioridad sobre bloque B
          } else if (direction == directionB && direction != directionA) {
            return 1; // Bloque B tiene prioridad sobre bloque A
          }
        }
        return distanceComparison;
      });

    for (final block in sortedCollidables) {
      switch (direction) {
        case 'derecha':
          if (playerX + 16 == block.x && playerY == block.y) {
            return block;
          } else {
            return CollisionBlock();
          }
        case 'izquierda':
          if (playerX == block.x + block.width && playerY == block.y) {
            return block;
          } else {
            return CollisionBlock();
          }
        case 'arriba':
          if (playerY == block.y + block.height && playerX == block.x) {
            return block;
          } else {
            return CollisionBlock();
          }
        case 'abajo':
          if (playerY + 16 == block.y && playerX == block.x) {
            return block;
          } else {
            return CollisionBlock();
          }
      }
    }

    return CollisionBlock(type: 'err');
  }

  /*
  *  _spriteAnimationsGenerator: Metodo generador de animaciones
  * */
  SpriteAnimation _spriteAnimationsGenerator(
      String direction, String state, int amount, double stepTime) {
    SpriteAnimation spriteAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('objetos_animados/jugador/$state$direction.png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ));
    return spriteAnimation;
  }

  void reiniciar() {
    position.x = startPositionX;
    position.y = startPositionY;
    calloEnLaTrampa = false;
    current = initialState;
    itemDropComponent != null ? parent!.add(itemDropComponent!) : print('No hay item');
    itemDropFalsoComponent != null ? parent!.add(itemDropFalsoComponent!) : print('No hay item');
    victoryItemComponent != null ? parent!.add(victoryItemComponent!) : print('No hay item');
    itemDrop = CollisionBlock();
    itemDropFalso = CollisionBlock();
    victoryItem = CollisionBlock();
    playerRespuesta = {
      "Llego a la meta": false,
      "Mejor camino": false,
      "No choco con obstaculos": true,
      "Recogio el objeto/item": false,
    };
    
  }
}
