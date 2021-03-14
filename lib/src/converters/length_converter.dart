import 'package:json_annotation/json_annotation.dart';
import 'package:svg_parser/src/types/length_type.dart';

final String LengthTypeRegex = r'^([0-9]+(\.[0-9]*)?)(em|ex|px|in|cm|mm|pt|pc|%)?$';

class LengthConverter implements JsonConverter<LengthType?, String?> {
  const LengthConverter();

  @override
  LengthType? fromJson(String? json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    var matches = RegExp(LengthTypeRegex).allMatches(json);

    if (matches.isEmpty) {
      return null;
    }

    var numberString = matches.first.group(1);
    var unitString = matches.first.group(3);
    LengthUnit? unit;

    if (numberString == null) {
      return null;
    }

    switch (unitString) {
      case 'em':
        unit = LengthUnit.emUnit;
        break;
      case 'ex':
        unit = LengthUnit.exUnit;
        break;
      case 'px':
        unit = LengthUnit.pxUnit;
        break;
      case 'in':
        unit = LengthUnit.inUnit;
        break;
      case 'cm':
        unit = LengthUnit.cmUnit;
        break;
      case 'mm':
        unit = LengthUnit.mmUnit;
        break;
      case 'pt':
        unit = LengthUnit.ptUnit;
        break;
      case 'pc':
        unit = LengthUnit.pcUnit;
        break;
      case '%':
        unit = LengthUnit.percentage;
        break;
    }

    return LengthType(num.parse(numberString), unit);
  }

  @override
  String? toJson(LengthType? object) {
    return null;
  }
}
