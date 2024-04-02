class PreferenceObject {
  String countryName;
  bool isSelected;

  PreferenceObject(this.countryName, this.isSelected);
  void selectionChange() {
    isSelected = !isSelected;
  }
}
