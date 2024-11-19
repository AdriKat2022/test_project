import 'package:test_project/utils/poolable_object.dart';

// Objects are not removed from the pool, they are just marked as available or not.
// The pool flag is located in the Object itself since it should be implementing a PoolableObject.
class ObjectPool<T extends PoolableObject>{
  final List<T> pool = [];
  final int maxSize;
  final T Function() createObjectFunction;

  ObjectPool({required this.maxSize, required this.createObjectFunction});

  // Get an object from the pool (or create one)
  T? getObject(){

    // Search for an available object in the pool
    for(var object in pool){
      if(object.isPooled){
        object.unpool();
        print("Object un-pooled!");
        return object;
      }
    }

    // Create a new object if none is available
    if (pool.length < maxSize){
      final poolableObject = createObjectFunction();
      pool.add(poolableObject);
      poolableObject.unpool();
      print("Object created and un-pooled!");
      return poolableObject;
    }

    print("Pool is all occupied!");
    return null;
  }
}