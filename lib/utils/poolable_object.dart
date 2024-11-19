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