import 'package:flame/components.dart';
import 'package:test_project/utils/poolable_object.dart';

class ObjectPool<T extends PoolableObject>{
  final List<T> pool = [];
  final int maxSize;
  final T Function() createObjectFunction;
  // Can be defined so this is executed 
  final void Function(T)? resetObjectFunction;

  ObjectPool({required this.maxSize, required this.createObjectFunction, this.resetObjectFunction = null});

  // Get an object from the pool (or create one)
  T? getObject({Vector2? spawnPosition = null, bool resetObject = true}){

    // Search for an available object in the pool (with the isMounted property)
    for(var object in pool){
      if(!object.isObjectPooled()){
        object.unpool();
        return object;
      }
    }

    // Create a new object if none is available
    if (pool.length < maxSize){
      final newObject = createObjectFunction();
      pool.add(newObject);
      return newObject;
    }

    print("Pool is all occupied!");
    return null;
  }

  void emptyPool(){
    pool.clear();
  }
}