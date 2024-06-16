import 'package:flutter/material.dart';

enum LanguageType { English, Vietnamese }

const String VIETNAMESE = "vi";
const String ENGLISH = "en";
const String ASSETS_PATH_LOCALISATIONS = "assets/translations";
const Locale VN_LOCAL = Locale("vi");
const Locale ENGLISH_LOCAL = Locale("en");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.English:
        return ENGLISH;
      case LanguageType.Vietnamese:
        return VIETNAMESE;
    }
  }
}
