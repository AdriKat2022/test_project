class DamageableComponent {
  int maxHp;
  late int hp;

  DamageableComponent(this.maxHp) {
    hp = maxHp;
  }

  void takeDamage(int damage) {
    hp -= damage;
    if (hp < 0) hp = 0;
    // TODO: Add a sound effect + visual effect
  }

  void heal(int healAmount) {
    hp += healAmount;
    if (hp > maxHp) hp = maxHp;
    // TODO: Add a sound effect + visual effect
  }

  bool isDead() {
    return hp <= 0;
  }
}