// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PathElement _$PathElementFromJson(Map<String, dynamic> json) {
  return PathElement(
    d: json['d'] as String? ?? '',
  )
    ..id = json['id'] as String?
    ..lang = json['lang'] as String?
    ..tabindex = json['tabindex'] as int?
    ..xmlLang = json['xmlLang'] as String?
    ..fill = const PaintConverter().fromJson(json['fill'] as String?)
    ..fillRule = _$enumDecodeNullable(_$FillRuleTypeEnumMap, json['fill-rule'])
    ..stroke = const PaintConverter().fromJson(json['stroke'] as String?)
    ..strokeLinecap =
        _$enumDecodeNullable(_$StrokeLinecapTypeEnumMap, json['stroke-linecap'])
    ..strokeWidth =
        const LengthConverter().fromJson(json['stroke-width'] as String?)
    ..transform = json['transform'] as String?
    ..pathLength = json['pathLength'] as num?;
}

Map<String, dynamic> _$PathElementToJson(PathElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lang': instance.lang,
      'tabindex': instance.tabindex,
      'xmlLang': instance.xmlLang,
      'fill': const PaintConverter().toJson(instance.fill),
      'fill-rule': _$FillRuleTypeEnumMap[instance.fillRule],
      'stroke': const PaintConverter().toJson(instance.stroke),
      'stroke-linecap': _$StrokeLinecapTypeEnumMap[instance.strokeLinecap],
      'stroke-width': const LengthConverter().toJson(instance.strokeWidth),
      'transform': instance.transform,
      'd': instance.d,
      'pathLength': instance.pathLength,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$FillRuleTypeEnumMap = {
  FillRuleType.nonzero: 'nonzero',
  FillRuleType.evenodd: 'evened',
  FillRuleType.inherit: 'inherit',
};

const _$StrokeLinecapTypeEnumMap = {
  StrokeLinecapType.butt: 'butt',
  StrokeLinecapType.round: 'round',
  StrokeLinecapType.square: 'square',
};
