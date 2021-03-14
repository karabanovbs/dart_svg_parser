import 'package:svg_parser/src/converters/length_converter.dart';
import 'package:svg_parser/src/converters/paint_converter.dart';
import 'package:svg_parser/src/types/length_type.dart';
import 'package:test/test.dart';

void main() {
  test('PaintConverter', () {
    var paint = PaintConverter().fromJson('indianred');

    expect(paint?.color, [255, 205, 92]);
    expect(paint?.opacity, 92);

    paint = PaintConverter().fromJson('rgb(255,0,0)');

    expect(paint?.color, [255, 0, 0]);
    expect(paint?.opacity, 255);

    paint = PaintConverter().fromJson('rgba(0,0,255,0.5)');

    expect(paint?.color, [0, 0, 255]);
    expect(paint?.opacity, (255 * 0.5).round());

    paint = PaintConverter().fromJson('#f00');

    expect(paint?.color, [255, 0, 0]);
    expect(paint?.opacity, 255);

    paint = PaintConverter().fromJson('#ff0000');

    expect(paint?.color, [255, 0, 0]);
    expect(paint?.opacity, 255);
  });
}
