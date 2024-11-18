import 'package:flame/components.dart';

class PoolableObject<T extends Component> {
  bool isPooled = false;
  final T object;

  PoolableObject(this.object);

  bool isObjectPooled(){
    return isPooled;
  }

  void pool() {
    isPooled = true;
  }

  void unpool() {
    isPooled = false;
  }
}