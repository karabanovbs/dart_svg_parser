class LengthType {
  final num value;
  final LengthUnit? unit;

  LengthType(this.value, [this.unit]);
}

enum LengthUnit {
  emUnit,
  exUnit,
  pxUnit,
  inUnit,
  cmUnit,
  mmUnit,
  ptUnit,
  pcUnit,
  percentage,
}
