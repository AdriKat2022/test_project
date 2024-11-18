import 'package:flame/components.dart';

class ObjectPool<T extends PositionComponent>{
  final List<T> pool = [];
  final int maxSize;
  final T Function() createObjectFunction;
  final void Function(T)? resetObjectFunction;

  ObjectPool({required this.maxSize, required this.createObjectFunction, this.resetObjectFunction = null});

  // Get an object from the pool (or create one)
  T? getObject({Vector2? spawnPosition = null, bool resetObject = false}){

    // Search for an available object in the pool (with the isMounted property)
    for(var object in pool){
      if(!object.isMounted){
        if (resetObject) resetObjectFunction!(object);
        if (spawnPosition != null) object.position = spawnPosition;
        return object;
      }
    }

    // Create a new object if none is available
    if (pool.length < maxSize){
      final newObject = createObjectFunction();
      if (resetObject) resetObjectFunction!(newObject);
      if (spawnPosition != null) newObject.position = spawnPosition;
      pool.add(newObject);
      return newObject;
    }

    print("Pool depleted !");
    return null;
  }

  void resetPool(){
    for (var obj in pool){
      if(obj.isMounted){
        obj.removeFromParent();
      }
    }
  }
}