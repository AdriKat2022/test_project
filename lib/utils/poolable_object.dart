/// Need to be implemented by objects that can be pooled (that needs to use ObjectPool<T>).
/// Will be turned into a mixin class for easier and less repetitive implementation.
abstract class PoolableObject {
  
  bool isPooled = false;

  void pool(){
    isPooled = true;
  }

  void unpool(){
    isPooled = false;
  }

  /// Override this method to reset the object to its initial state. This is optionnal.
  void reset(){
  }
}