import 'package:svg_parser/src/attributes/core_attributes.dart';

class UnknownElement implements CoreAttributes {
  UnknownElement();

  @override
  String? id;

  @override
  String? lang;

  @override
  int? tabindex;

  @override
  String? xmlLang;

}