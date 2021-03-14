import 'package:svg_parser/src/converters/length_converter.dart';
import 'package:svg_parser/src/types/length_type.dart';
import 'package:test/test.dart';

void main() {
  test('LengthConverter', () {
    var length = LengthConverter().fromJson('1px');

    expect(length?.value, 1);
    expect(length?.unit, LengthUnit.pxUnit);

    length = LengthConverter().fromJson('1.5%');

    expect(length?.value, 1.5);
    expect(length?.unit, LengthUnit.percentage);
  });
}
