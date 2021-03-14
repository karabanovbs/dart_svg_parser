import 'package:json_annotation/json_annotation.dart';

class IntegerConverter implements JsonConverter<int?, String?> {
  const IntegerConverter();

  @override
  int? fromJson(String? json) {
    return int.tryParse(json ?? '');
  }

  @override
  String? toJson(int? object) {
    return null;
  }
}
