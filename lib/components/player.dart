import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:test_project/components/damageable_component.dart';
import 'package:test_project/components/enemy.dart';
import 'package:test_project/data/audio_manager.dart';
import 'package:test_project/effects/sprite_color_flash.dart';
import 'package:test_project/main.dart';
import 'package:test_project/components/bullet.dart';
import 'package:test_project/utils/object_pool.dart';

class Player extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame>, CollisionCallbacks, DamageableComponent {

  static const double bulletsPerSecond = 4;
  static const double bulletsBaseDamage = 5;

  int points = 0;

  late final SpawnComponent bulletSpawner;
  late final ObjectPool<Bullet> playerBulletPool;
  late final SpriteColorFlash spriteColorFlash;

  Player({double maxHP = 3}) : super(
    size: Vector2(100, 150) * 0.8,
    anchor: Anchor.center,
  ){
    setMaxHp(maxHP);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = game.size/2;
    spriteColorFlash = SpriteColorFlash(this, 0, 0.1, 0.5, Color(0xFFFF0000));

    // Load Animation.
    animation = await game.loadSpriteAnimation(
      'ships/player_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2(32, 48),
      ),
    );
    add(RectangleHitbox(collisionType: CollisionType.active));

    // TODO: Move the bullet pool and the bullet spawner to a separate class (weapon component).
    // Initialize BulletPool.
    playerBulletPool = ObjectPool<Bullet>(
      maxSize: 20,
      createObjectFunction: () => Bullet(),
    );

    // Initialize Bullet Spawner using the ObjectPool.
    bulletSpawner = SpawnComponent(
      period: 1/bulletsPerSecond,
      selfPositioning: true,
      factory: (index) {
        AudioManager.playSound('player_bullet');
        final bullet = playerBulletPool.get();
        if (bullet != null){
          bullet.position = position + Vector2(0, -height/2);
          bullet.setDamage(bulletsBaseDamage);
          return bullet;
        }
        throw Exception("Pool is all occupied!");
      },
      autoStart: false,
    );

    game.add(bulletSpawner);
  }

  void selectTintColor(Color color){
    decorator.removeLast();
    decorator.addLast(PaintDecorator.tint(color));
  }

  void move(Vector2 delta){
    if (isHpZeroOrBelow()) return;
    position.add(delta);
  }

  void startShooting(){
    if (isHpZeroOrBelow()) return;
    bulletSpawner.timer.start();
  }

  void stopShooting(){
    if (isHpZeroOrBelow()) return;
    bulletSpawner.timer.stop();
  }

  void addScore(int score){
    points += score;
    game.gameUI.scoreComponent.updateScore(points);
  }

  void disablePlayer(){
    bulletSpawner.timer.stop();
    removeFromParent();
    game.gameOver();
  }

  void reset(){
    fullHeal();
    game.gameUI.heartsBar.updateLives(hp.toInt());
    game.gameUI.scoreComponent.updateScore(0);
    points = 0;
    position = game.size/2;
    playerBulletPool.emptyPool();
    removeFromParent();
    game.add(this);
  }

  void damagePlayer(){
    spriteColorFlash.activate();
    takeDamage(1);
    if (isHpZeroOrBelow()){
      disablePlayer();
    }
    game.gameUI.heartsBar.updateLives(hp.toInt());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (isHpZeroOrBelow()) return;
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy){
      print("player took damage");
      other.death(false);
      damagePlayer();
    }
  }
}