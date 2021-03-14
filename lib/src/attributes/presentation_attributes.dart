import 'package:svg_parser/src/types/fill_rule_type.dart';
import 'package:svg_parser/src/types/length_type.dart';
import 'package:svg_parser/src/types/paint_type.dart';
import 'package:svg_parser/src/types/stroke_linecap_type.dart';

class PresentationAttributes {
  PaintType? fill;
  FillRuleType? fillRule;
  PaintType? stroke;
  LengthType? strokeWidth;
  StrokeLinecapType? strokeLinecap;
  String? transform;
}
