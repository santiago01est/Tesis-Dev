import 'dart:async';

import 'package:dev_tesis/game/components/collision_block.dart';
import 'package:dev_tesis/game/components/custom_hitbox.dart';
import 'package:dev_tesis/game/utilities/player_utils.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

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
  victory
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

  late final double startPositionX;
  late final double startPositionY;

  final double stepTime = 1 / 6;

  List<CollisionBlock> collisionBlocks = [];

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
    idleRightAnimation = _spriteAnimationsGenerator('right', 'idle-', 6);
    idleLeftAnimation = _spriteAnimationsGenerator('left', 'idle-', 6);
    idleUpAnimation = _spriteAnimationsGenerator('up', 'idle-', 6);
    idleDownAnimation = _spriteAnimationsGenerator('down', 'idle-', 6);
    runningRightAnimation = _spriteAnimationsGenerator('right', 'run-', 6);
    runningLeftAnimation = _spriteAnimationsGenerator('left', 'run-', 6);
    runningUpAnimation = _spriteAnimationsGenerator('up', 'run-', 6);
    runningDownAnimation = _spriteAnimationsGenerator('down', 'run-', 6);
    downDeathAnimation = _spriteAnimationsGenerator('down', 'death-', 6);
    rightDeathAnimation = _spriteAnimationsGenerator('right', 'death-', 6);
    leftDeathAnimation = _spriteAnimationsGenerator('left', 'death-', 6);
    upDeathAnimation = _spriteAnimationsGenerator('up', 'death-', 6);
    victoryAnimation = _spriteAnimationsGenerator('', 'victory2', 4);

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
      PlayerState.victory: victoryAnimation
    };
    current = PlayerState.idleR;
  }

  /*
  * processMovementInstructions: metodo que se encarga de procesar las instrucciones
  * de movimiento del jugador pasadas desde la interfaz del nivel y retornar un boolean
  * que indica si se llego a la meta o no.
  **/
  Future<bool> processMovementInstructions() async {
    // ignore: unnecessary_null_comparison
    if (movementInstructions != null || movementInstructions.isNotEmpty) {
      return await _executeInstructions();
    }
    return false;
  }

  Future<bool> _executeInstructions() async {
    var i = 0;
    bool response = false;
    for (var movement in movementInstructions) {
      i++;
      final instruction = movement;
      response = i == movementInstructions.length ? 
      await _executeInstruction(instruction, true) : await _executeInstruction(instruction, false);
    }
    return response;
  }

  Future<bool> _executeInstruction(
      String instruction, bool lastInstruction) async {
    final block = _checkNextBlockForCollision(instruction);
    if (block.type == 'err') {
      // ignore: avoid_print
      print('Hubo un error');
    }
    if (instruction == 'derecha') {
      return _executeDisplacement(
          block, lastInstruction, PlayerState.runningR, PlayerState.idleR, Vector2(16, 0));
    }
    if (instruction == 'izquierda') {
      return _executeDisplacement(
          block, lastInstruction, PlayerState.runningL, PlayerState.idleL, Vector2(-16, 0));
    }
    if (instruction == 'arriba') {
      return _executeDisplacement(
          block, lastInstruction, PlayerState.runningU, PlayerState.idleU, Vector2(0, -16));
    }
    if (instruction == 'abajo') {
      return _executeDisplacement(
          block, lastInstruction, PlayerState.runningD, PlayerState.idleD, Vector2(0, 16));
    }

    if (instruction == 'giroDeDerecha') {
      
    }

    if (instruction == 'giroDeIzquierda') {
      
    }
    return false;
  }

  Future<bool> _executeDisplacement(

        CollisionBlock block,
        bool lastInstruction,
        PlayerState movementState,
        PlayerState idleState,
        Vector2 movementVector

      ) async {
        
    if (block.type == 'null') {
      current = movementState;
      add(MoveByEffect(movementVector, EffectController(duration: 0.333)));
      await Future.delayed(const Duration(milliseconds: 333));
      current = idleState;
    } else if (block.type == 'Meta' && lastInstruction == true) {
      current = movementState;
      add(MoveByEffect(movementVector, EffectController(duration: 0.333)));
      await Future.delayed(const Duration(milliseconds: 333));
      current = PlayerState.victory;
      return true;
    }
    currentInstructionIndex += 1;
    return false;
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
      String direction, String state, int amount) {
    SpriteAnimation spriteAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('objetos_animados/jugador/$state$direction.png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ));
    return spriteAnimation;
  }
}