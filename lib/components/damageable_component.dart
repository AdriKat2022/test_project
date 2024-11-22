/// HP are stored as an integer value, and the max HP is set in the constructor. Use it as part of any entity that can take damage.
mixin class DamageableComponent {

  double get hp => _hp;

  late double _hp = 10;
  double _maxHp = 10;

  /// Sets the new maxHP and optionally sets the current HP of the entity to that new maxHP.
  void setMaxHp(double newMaxHp, {bool heal = true}) {
    _maxHp = newMaxHp;
    if (_hp > _maxHp || heal) fullHeal();
    _hp = _maxHp;
  }

  /// Fully heals the entity.
  void fullHeal() {
    _hp = _maxHp;
  }

  /// Returns true if the entity is dead.
  bool takeDamage(double damage) {
    _hp -= damage;
    if (hp < 0) _hp = 0;
    return isHpZeroOrBelow();
  }

  void heal(int healAmount) {
    _hp += healAmount;
    if (_hp > _maxHp) _hp = _maxHp;
  }

  bool isHpZeroOrBelow() {
    return _hp <= 0;
  }
}