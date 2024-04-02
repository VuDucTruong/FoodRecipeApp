class MutableVariable<T> {
  T value;

  MutableVariable(this.value);

  void changeValue(T newValue) {
    this.value = newValue;
  }
}
