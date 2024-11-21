/// HP are stored as an integer value, and the max HP is set in the constructor. Use it as part of any entity that can take damage.
class DamageableComponent {
  int maxHp;
  late int hp;

  DamageableComponent(this.maxHp) {
    hp = maxHp;
  }

  void setMaxHp(int newMaxHp) {
    maxHp = newMaxHp;
    hp = maxHp;
  }

  /// Returns true if the entity is dead.
  bool takeDamage(int damage) {
    hp -= damage;
    if (hp < 0) hp = 0;
    // TODO: Add a sound effect + visual effect.

    return isDead();
  }

  void heal(int healAmount) {
    hp += healAmount;
    if (hp > maxHp) hp = maxHp;
    // TODO: Add a sound effect + visual effect.
  }

  bool isDead() {
    return hp <= 0;
  }
}