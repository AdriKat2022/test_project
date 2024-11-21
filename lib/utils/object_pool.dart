import 'package:test_project/utils/poolable_object.dart';

/// Objects are not removed from the pool, they are just marked as available or not.
/// The pool flag is located in the Object itself since it should be implementinh the PoolableObject interface.
class ObjectPool<T extends PoolableObject>{
  final List<T> pool = [];
  final int maxSize;
  final T Function() createObjectFunction;

  ObjectPool({required this.maxSize, required this.createObjectFunction});

  /// Get an object from the pool (or create one).
  T? get(){

    // Search for an available object in the pool.
    for(var object in pool){
      if(object.isPooled){
        object.unpool();
        object.reset();
        print(T.toString() + " un-pooled!");
        return object;
      }
    }

    // Create a new object if none is available.
    if (pool.length < maxSize){
      final poolableObject = createObjectFunction();
      pool.add(poolableObject);
      poolableObject.unpool();
      poolableObject.reset();
      print(T.toString() + " created and un-pooled!");
      return poolableObject;
    }

    print("Pool is all occupied!");
    return null;
  }

  /// Puts an object back into the pool.
  /// Mostly unused in this project since objects sets their flag on their own instead of using this function.
  void putBack(T object){
    if (pool.contains(object)){
      object.pool();
      print(T.toString() + " re-pooled!");
    }
  }
}