/// HP are stored as an integer value, and the max HP is set in the constructor. Use it as part of any entity that can take damage.
mixin class DamageableComponent {

  int maxHp = 10;
  late int hp = 10;

  /// Sets the new maxHP and optionally sets the current HP of the entity to that new maxHP.
  void setMaxHp(int newMaxHp, {bool heal = true}) {
    maxHp = newMaxHp;
    if (hp > maxHp || heal) fullHeal();
    hp = maxHp;
  }

  /// Fully heals the entity.
  void fullHeal() {
    hp = maxHp;
  }

  /// Returns true if the entity is dead.
  bool takeDamage(int damage) {
    hp -= damage;
    if (hp < 0) hp = 0;
    // TODO: Add a sound effect + visual effect.

    return isHpZeroOrBelow();
  }

  void heal(int healAmount) {
    hp += healAmount;
    if (hp > maxHp) hp = maxHp;
    // TODO: Add a sound effect + visual effect.
  }

  bool isHpZeroOrBelow() {
    return hp <= 0;
  }
}