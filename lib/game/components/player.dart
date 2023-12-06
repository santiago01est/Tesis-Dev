import 'dart:async';

import 'package:dev_tesis/game/components/collision_block.dart';
import 'package:dev_tesis/game/components/custom_hitbox.dart';
import 'package:dev_tesis/game/components/utils.dart';
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

  Player({position, priority})
      : super(position: position, priority: priority);

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

  final double stepTime = 1/6;

  List<CollisionBlock> collisionBlocks = [];

  CustomHitbox hitbox =
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
    //Lista de todas las animaciones
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

  Future<bool> executeResponse() async {
    // ignore: unnecessary_null_comparison
    if (movementInstructions!=null || movementInstructions.isNotEmpty) {
      return await _execute();
    }
    return false;

  }

  Future<bool> _executeInstruction(String instruction, bool lastInstruction) async {
    final block = _checkNextBlockForCollision(instruction);
    if (block.type == 'err') {
      print('Hubo un error');
    }
    if (instruction == 'derecha') {
      if (block.type == 'null') {
        current = PlayerState.runningR;
        add(MoveByEffect(Vector2(16, 0), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        current = PlayerState.idleR;
      } else if (block.type == 'Meta' && lastInstruction==true) {
        current = PlayerState.runningR;
        add(MoveByEffect(Vector2(16, 0), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        _victory(PlayerState.victory);
        return true;
      }
    }
    if (instruction == 'izquierda') {
      if (block.type == 'null') {
        current = PlayerState.runningL;
        add(MoveByEffect(Vector2(-16, 0), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        current = PlayerState.idleL;
      } else if (block.type == 'Meta' && lastInstruction==true) {
        current = PlayerState.runningL;
        add(MoveByEffect(Vector2(-16, 0), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        _victory(PlayerState.victory);
        return true;
      }
    }
    if (instruction == 'arriba') {
      if (block.type == 'null') {
        current = PlayerState.runningU;
        add(MoveByEffect(Vector2(0, -16), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        current = PlayerState.idleU;
      } else if (block.type == 'Meta' && lastInstruction==true) {
        current = PlayerState.runningU;
        add(MoveByEffect(Vector2(0, -16), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        _victory(PlayerState.victory);
        return true;
      }
    }
    if (instruction == 'abajo') {
      if (block.type == 'null') {
        current = PlayerState.runningD;
        add(MoveByEffect(Vector2(0, 16), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        current = PlayerState.idleD;
      } else if (block.type == 'Meta' && lastInstruction==true) {
        current = PlayerState.runningD;
        add(MoveByEffect(Vector2(0, 16), EffectController(duration: 0.333)));
        await Future.delayed(const Duration(milliseconds: 333));
        _victory(PlayerState.victory);
        return true;
      }
    }
    currentInstructionIndex += 1;
    return false;
  }


  SpriteAnimation _spriteAnimationsGenerator(
      String direction, String state, int amount) {
    SpriteAnimation spriteAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('animation_object/player/$state$direction.png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ));
    return spriteAnimation;
  }

  Future<bool> _execute() async {
    var i=0;
    bool response= false;
    for (var movement in movementInstructions) {
      i++;
      final instruction = movement;
      if (i == movementInstructions.length) {
        response= await _executeInstruction(instruction, true);
      }
      else{
        response= await _executeInstruction(instruction, false);
      }
      
    }
    return response;
  }

/*   void _hitSpikes(PlayerState deathPosition) {
    const hitDuration = Duration(milliseconds: 1200);
    current = deathPosition;

    Future.delayed(hitDuration, () {
      current = PlayerState.idleR;
      position = Vector2(40, 20);
    });
  } */

  void _victory(PlayerState victoryAnimation) {
    current = victoryAnimation;

  }

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
}
