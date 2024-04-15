import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

class Uint32Converter implements JsonConverter<Uint32, String> {
  const Uint32Converter();

  @override
  Uint32 fromJson(String json) {
    int value = int.tryParse(json) ?? 0;
    if (value < 0 || value > 4294967295) {
      throw RangeError("Value '$json' is outside valid Uint32 range");
    }
    return value as Uint32;
  }

  @override
  String toJson(Uint32 object) => object.toString();
}
class Uint8Converter implements JsonConverter<Uint8, String> {
  const Uint8Converter();

  @override
  Uint8 fromJson(String json) {
    int value = int.tryParse(json) ?? 0;
    if (value < 0 || value > 255) {
      throw RangeError("Value '$json' is outside valid Uint8 range");
    }
    return value as Uint8;
  }

  @override
  String toJson(Uint8 object) => object.toString();
}

class Uint16Converter implements JsonConverter<Uint16, String> {
  const Uint16Converter();

  @override
  Uint16 fromJson(String json) {
    int value = int.tryParse(json) ?? 0;
    if (value < 0 || value > 65535) {
      throw RangeError("Value '$json' is outside valid Uint16 range");
    }
    return value as Uint16;
  }

  @override
  String toJson(Uint16 object) => object.toString();
}

class Uint64Converter implements JsonConverter<Uint64, String> {
  const Uint64Converter();

  @override
  Uint64 fromJson(String json) {
    // BigInt is required for Uint64 as int has a smaller range
    BigInt value = BigInt.parse(json);
    if (value < BigInt.zero || value > BigInt.from(4294967295) * BigInt.from(2) + BigInt.from(4294967295)) {
      throw RangeError("Value '$json' is outside valid Uint64 range");
    }
    return value as Uint64;
  }

  @override
  String toJson(Uint64 object) => object.toString();
}
