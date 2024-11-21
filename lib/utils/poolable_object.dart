/// Need to be implemented by objects that can be pooled (that needs to use ObjectPool<T>).
abstract class PoolableObject {
  
  bool isPooled = false;

  void pool(){
    isPooled = true;
  }

  void unpool(){
    isPooled = false;
  }

  void reset();
}