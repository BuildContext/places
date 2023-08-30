extension SetExtensions<E> on Set {
  void addOrRemove(E element) {
    contains(element) ? remove(element) : add(element);
  }
}
