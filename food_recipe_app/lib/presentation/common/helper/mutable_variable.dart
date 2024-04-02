class MutableVariable<T extends num> {
  T value;

  MutableVariable(this.value);

  void changeValue(T newValue) {
    this.value = newValue;
  }
}
