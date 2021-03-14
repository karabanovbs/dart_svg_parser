import 'package:svg_parser/src/data/svg_element.dart';
import 'package:svg_parser/src/data/path_element.dart';
import 'package:svg_parser/src/types/stroke_linecap_type.dart';
import 'package:test/test.dart';

void main() {
  test('PathElement own attributes', () {
    var svg = SvgElement.fromXml('''
      <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
        <path d="M 10,30
                 A 20,20 0,0,1 50,30
                 A 20,20 0,0,1 90,30
                 Q 90,60 50,90
                 Q 10,60 10,30 z"/>
      </svg>
    ''');

    expect(svg.children?.length, 1);
    expect(svg.children?.first.runtimeType, PathElement);
    expect((svg.children?.first as PathElement).d, '''M 10,30
                 A 20,20 0,0,1 50,30
                 A 20,20 0,0,1 90,30
                 Q 90,60 50,90
                 Q 10,60 10,30 z''');
  });

  test('PathElement PresentationAttributes', () {
    var svg = SvgElement.fromXml('''
      <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
        <path d="M 10,30
                 A 20,20 0,0,1 50,30
                 A 20,20 0,0,1 90,30
                 Q 90,60 50,90
                 Q 10,60 10,30 z" stroke-width="2%" stroke-linecap="round"/>
      </svg>
    ''');
    expect((svg.children?.first as PathElement).strokeWidth?.value, 2);
    expect((svg.children?.first as PathElement).strokeLinecap,
        StrokeLinecapType.round);
  });
}
