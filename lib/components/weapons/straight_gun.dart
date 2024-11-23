import 'dart:ui';

import 'package:flame/components.dart';
import 'package:test_project/components/bullet.dart';
import 'package:test_project/components/weapons/weapon.dart';
import 'package:test_project/utils/log_debug.dart';

/// The simplest weapon, shoots straight bullets.
class StraightGun extends Weapon<Bullet> {

  StraightGun({required super.owner, required super.positionTarget, damage = 5, fireRate = 0.1, Vector2? offset, Color? bulletColor}) : super(
    damage: damage,
    fireRate: fireRate,
    createObjectFunction: () => Bullet(),
    factoryFunction: (int index, Bullet bullet) {
      LogDebug.printToHUD(owner, "Bullet $index created. Position: ${bullet.position}", key: 1);
      return bullet;
    },
    offset: offset,
    bulletColor: bulletColor,
  );

  @override
  void init() {
    super.init();
    LogDebug.printLog("StraightGun initialized.");
  }
  
  @override
  void secondaryAction(bool pressed) {
    // No special secondary action.
    LogDebug.printLog("Secondary action trigger: ${(pressed ? "pressed" : "released")}");
  }
}