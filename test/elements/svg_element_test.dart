import 'package:svg_parser/src/data/svg_element.dart';
import 'package:svg_parser/src/types/length_type.dart';
import 'package:test/test.dart';

void main() {
  test('SvgElement CoreAttributes', () {
    var id = '0';
    var lang = 'en-US';
    var tabindex = 1;
    var xmlLang = 'ru-RU';
    var svg = SvgElement.fromXml('''
      <svg id="$id" lang="$lang" tabindex="$tabindex" xml:lang="$xmlLang">
      </svg>
    ''');

    expect(svg.id, id);
    expect(svg.lang, lang);
    expect(svg.tabindex, tabindex);
    expect(svg.xmlLang, xmlLang);
  });

  test('SvgElement Own Attributes', () {
    var height = '0px';
    var width = '1em';
    var x = '2%';
    var y = '3pt';
    var svg = SvgElement.fromXml('''
      <svg 
        height="$height" 
        width="$width"
        x="$x"
        y="$y"
        
      >
      </svg>
    ''');

    expect(svg.height?.value, 0);
    expect(svg.height?.unit, LengthUnit.pxUnit);

    expect(svg.width?.value, 1);
    expect(svg.width?.unit, LengthUnit.emUnit);

    expect(svg.x?.value, 2);
    expect(svg.x?.unit, LengthUnit.percentage);

    expect(svg.y?.value, 3);
    expect(svg.y?.unit, LengthUnit.ptUnit);
  });

}
