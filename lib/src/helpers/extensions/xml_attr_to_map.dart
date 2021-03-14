import 'package:xml/xml.dart';

const String childrenKey = '_children';

extension XmlElementToMapExt on XmlElement {
  Map<String, dynamic> toMap() => Map.fromEntries(
        [
          ...attributes.map(
            (attr) => MapEntry(attr.name.toString(), attr.value),
          ),
          MapEntry(childrenKey, nodes.whereType<XmlElement>()),
        ],
      );
}
