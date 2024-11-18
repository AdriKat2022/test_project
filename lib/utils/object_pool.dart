import 'package:flame/components.dart';
import 'package:test_project/utils/poolable_object.dart';

class ObjectPool<T extends Component>{
  final List<PoolableObject<T>> pool = [];
  final int maxSize;
  final T Function() createObjectFunction;

  ObjectPool({required this.maxSize, required this.createObjectFunction});

  // Get an object from the pool (or create one)
  PoolableObject<T>? getObject(){

    // Search for an available object in the pool (with the isMounted property)
    for(var object in pool){
      if(!object.isObjectPooled()){
        object.unpool();
        return object;
      }
    }

    // Create a new object if none is available
    if (pool.length < maxSize){
      final poolableObject = PoolableObject(createObjectFunction());
      pool.add(poolableObject);
      return poolableObject;
    }

    print("Pool is all occupied!");
    return null;
  }

  void emptyPool(){
    pool.clear();
  }
}