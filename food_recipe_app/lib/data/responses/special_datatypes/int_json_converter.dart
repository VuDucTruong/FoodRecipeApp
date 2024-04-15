
import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

class Int8Converter implements JsonConverter<Int8, String> {
  const Int8Converter();

  @override
  Int8 fromJson(String json) {
    int value = int.parse(json);
    if (value < -128 || value > 127) {
      throw RangeError("Value '$json' is outside valid Int8 range");
    }
    return value as Int8;
  }

  @override
  String toJson(Int8 object) => object.toString();
}

class Int16Converter implements JsonConverter<Int16, String> {
  const Int16Converter();

  @override
  Int16 fromJson(String json) {
    int value = int.parse(json);
    if (value < -32768 || value > 32767) {
      throw RangeError("Value '$json' is outside valid Int16 range");
    }
    return value as Int16;
  }

  @override
  String toJson(Int16 object) => object.toString();
}

class Int32Converter implements JsonConverter<int, String> {
  const Int32Converter();

  @override
  int fromJson(String json) {
    return int.parse(json); // No range check needed for int32
  }

  @override
  String toJson(int object) => object.toString();
}

class Int64Converter implements JsonConverter<int, String> {
  const Int64Converter();

  @override
  int fromJson(String json) {
    return int.parse(json); // No range check needed for int64 (assuming full 64-bit range)
  }

  @override
  String toJson(int object) => object.toString();
}
