import 'package:svg_parser/src/types/paint_type.dart';
import 'package:json_annotation/json_annotation.dart';

const rgbRegex = r'^rgb\((\d{1,3}),(\d{1,3}),(\d{1,3})\)$';
const rgbaRegex = r'^rgba\((\d{1,3}),(\d{1,3}),(\d{1,3}),(\d{1,3})\)$';

class PaintConverter implements JsonConverter<PaintType?, String?> {
  const PaintConverter();

  @override
  PaintType? fromJson(String? json) {
    if (json != null) {
      if (namedColors.containsKey(json)) {
        return PaintType.color(
            namedColors[json]!.getRange(0, 3).toList(), namedColors[json]![3]);
      }

      return parsePaint(json);
    }

    return null;
  }

  @override
  String? toJson(PaintType? object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

PaintType? parsePaint(String? colorString) {
  if (colorString == null || colorString.isEmpty) {
    return null;
  }

  if (colorString == 'none') {
    return null;
  }

  // handle hex colors e.g. #fff or #ffffff.  This supports #RRGGBBAA
  if (colorString[0] == '#') {
    if (colorString.length == 4) {
      final r = colorString[1];
      final g = colorString[2];
      final b = colorString[3];
      colorString = '#$r$r$g$g$b$b';
    }
    if (colorString.length == 7) {
      return PaintType.color([
        int.parse(colorString.substring(1, 3), radix: 16),
        int.parse(colorString.substring(3, 5), radix: 16),
        int.parse(colorString.substring(5, 7), radix: 16),
      ]);
    }

    if (colorString.length == 9) {
      return PaintType.color([
        int.parse(colorString.substring(1, 3), radix: 16),
        int.parse(colorString.substring(3, 5), radix: 16),
        int.parse(colorString.substring(5, 7), radix: 16),
      ], int.parse(colorString.substring(7, 9), radix: 16));
    }
  }

  // handle rgba() colors e.g. rgba(255, 255, 255, 1.0)
  if (colorString.toLowerCase().startsWith('rgba')) {
    final rawColorElements = colorString
        .substring(colorString.indexOf('(') + 1, colorString.indexOf(')'))
        .split(',')
        .map((String rawColor) => rawColor.trim())
        .toList();

    final opacity = double.tryParse(rawColorElements.removeLast())!;

    final rgb =
        rawColorElements.map((String rawColor) => int.parse(rawColor)).toList();

    return PaintType.color(rgb, (255 * opacity).round());
  }

  // Conversion code from: https://github.com/MichaelFenwick/Color, thanks :)
  if (colorString.toLowerCase().startsWith('hsl')) {
    final values = colorString
        .substring(colorString.indexOf('(') + 1, colorString.indexOf(')'))
        .split(',')
        .map<int>((String rawColor) {
      rawColor = rawColor.trim();

      if (rawColor.endsWith('%')) {
        rawColor = rawColor.substring(0, rawColor.length - 1);
      }

      if (rawColor.contains('.')) {
        return (double.tryParse(rawColor)! * 2.55).round();
      }

      return int.parse(rawColor);
    }).toList();
    final hue = values[0] / 360 % 1;
    final saturation = values[1] / 100;
    final luminance = values[2] / 100;
    final alpha = values.length > 3 ? values[3] : 255;
    var rgb = <double>[0, 0, 0];

    if (hue < 1 / 6) {
      rgb[0] = 1;
      rgb[1] = hue * 6;
    } else if (hue < 2 / 6) {
      rgb[0] = 2 - hue * 6;
      rgb[1] = 1;
    } else if (hue < 3 / 6) {
      rgb[1] = 1;
      rgb[2] = hue * 6 - 2;
    } else if (hue < 4 / 6) {
      rgb[1] = 4 - hue * 6;
      rgb[2] = 1;
    } else if (hue < 5 / 6) {
      rgb[0] = hue * 6 - 4;
      rgb[2] = 1;
    } else {
      rgb[0] = 1;
      rgb[2] = 6 - hue * 6;
    }

    rgb =
        rgb.map((double val) => val + (1 - saturation) * (0.5 - val)).toList();

    if (luminance < 0.5) {
      rgb = rgb.map((double val) => luminance * 2 * val).toList();
    } else {
      rgb = rgb
          .map((double val) => luminance * 2 * (1 - val) + 2 * val - 1)
          .toList();
    }

    rgb = rgb.map((double val) => val * 255).toList();

    return PaintType.color(
        [rgb[0].round(), rgb[1].round(), rgb[2].round()], alpha);
  }

  // handle rgb() colors e.g. rgb(255, 255, 255)
  if (colorString.toLowerCase().startsWith('rgb')) {
    final rgb = colorString
        .substring(colorString.indexOf('(') + 1, colorString.indexOf(')'))
        .split(',')
        .map<int>((String rawColor) {
      rawColor = rawColor.trim();
      if (rawColor.endsWith('%')) {
        rawColor = rawColor.substring(0, rawColor.length - 1);
        return (double.tryParse(rawColor)! * 2.55).round();
      }
      return int.parse(rawColor);
    }).toList();

    // rgba() isn't really in the spec, but Firefox supported it at one point so why not.
    final a = rgb.length > 3 ? rgb[3] : 255;
    return PaintType.color([rgb[0].round(), rgb[1].round(), rgb[2].round()], a);
  }

  return null;
}

/// https://github.com/dnfield/flutter_svg/blob/f2a180642019f503cbe4b542c1b89e74fd584227/lib/src/svg/colors.dart
/// https://www.w3.org/TR/SVG11/types.html#ColorKeywords
/// TODO: maybe need move to package
///
const Map<String, List<int>> namedColors = <String, List<int>>{
  'aliceblue': [255, 240, 248, 255],
  'antiquewhite': [255, 250, 235, 215],
  'aqua': [255, 0, 255, 255],
  'aquamarine': [255, 127, 255, 212],
  'azure': [255, 240, 255, 255],
  'beige': [255, 245, 245, 220],
  'bisque': [255, 255, 228, 196],
  'black': [255, 0, 0, 0],
  'blanchedalmond': [255, 255, 235, 205],
  'blue': [255, 0, 0, 255],
  'blueviolet': [255, 138, 43, 226],
  'brown': [255, 165, 42, 42],
  'burlywood': [255, 222, 184, 135],
  'cadetblue': [255, 95, 158, 160],
  'chartreuse': [255, 127, 255, 0],
  'chocolate': [255, 210, 105, 30],
  'coral': [255, 255, 127, 80],
  'cornflowerblue': [255, 100, 149, 237],
  'cornsilk': [255, 255, 248, 220],
  'crimson': [255, 220, 20, 60],
  'cyan': [255, 0, 255, 255],
  'darkblue': [255, 0, 0, 139],
  'darkcyan': [255, 0, 139, 139],
  'darkgoldenrod': [255, 184, 134, 11],
  'darkgray': [255, 169, 169, 169],
  'darkgreen': [255, 0, 100, 0],
  'darkgrey': [255, 169, 169, 169],
  'darkkhaki': [255, 189, 183, 107],
  'darkmagenta': [255, 139, 0, 139],
  'darkolivegreen': [255, 85, 107, 47],
  'darkorange': [255, 255, 140, 0],
  'darkorchid': [255, 153, 50, 204],
  'darkred': [255, 139, 0, 0],
  'darksalmon': [255, 233, 150, 122],
  'darkseagreen': [255, 143, 188, 143],
  'darkslateblue': [255, 72, 61, 139],
  'darkslategray': [255, 47, 79, 79],
  'darkslategrey': [255, 47, 79, 79],
  'darkturquoise': [255, 0, 206, 209],
  'darkviolet': [255, 148, 0, 211],
  'deeppink': [255, 255, 20, 147],
  'deepskyblue': [255, 0, 191, 255],
  'dimgray': [255, 105, 105, 105],
  'dimgrey': [255, 105, 105, 105],
  'dodgerblue': [255, 30, 144, 255],
  'firebrick': [255, 178, 34, 34],
  'floralwhite': [255, 255, 250, 240],
  'forestgreen': [255, 34, 139, 34],
  'fuchsia': [255, 255, 0, 255],
  'gainsboro': [255, 220, 220, 220],
  'ghostwhite': [255, 248, 248, 255],
  'gold': [255, 255, 215, 0],
  'goldenrod': [255, 218, 165, 32],
  'gray': [255, 128, 128, 128],
  'grey': [255, 128, 128, 128],
  'green': [255, 0, 128, 0],
  'greenyellow': [255, 173, 255, 47],
  'honeydew': [255, 240, 255, 240],
  'hotpink': [255, 255, 105, 180],
  'indianred': [255, 205, 92, 92],
  'indigo': [255, 75, 0, 130],
  'ivory': [255, 255, 255, 240],
  'khaki': [255, 240, 230, 140],
  'lavender': [255, 230, 230, 250],
  'lavenderblush': [255, 255, 240, 245],
  'lawngreen': [255, 124, 252, 0],
  'lemonchiffon': [255, 255, 250, 205],
  'lightblue': [255, 173, 216, 230],
  'lightcoral': [255, 240, 128, 128],
  'lightcyan': [255, 224, 255, 255],
  'lightgoldenrodyellow': [255, 250, 250, 210],
  'lightgray': [255, 211, 211, 211],
  'lightgreen': [255, 144, 238, 144],
  'lightgrey': [255, 211, 211, 211],
  'lightpink': [255, 255, 182, 193],
  'lightsalmon': [255, 255, 160, 122],
  'lightseagreen': [255, 32, 178, 170],
  'lightskyblue': [255, 135, 206, 250],
  'lightslategray': [255, 119, 136, 153],
  'lightslategrey': [255, 119, 136, 153],
  'lightsteelblue': [255, 176, 196, 222],
  'lightyellow': [255, 255, 255, 224],
  'lime': [255, 0, 255, 0],
  'limegreen': [255, 50, 205, 50],
  'linen': [255, 250, 240, 230],
  'magenta': [255, 255, 0, 255],
  'maroon': [255, 128, 0, 0],
  'mediumaquamarine': [255, 102, 205, 170],
  'mediumblue': [255, 0, 0, 205],
  'mediumorchid': [255, 186, 85, 211],
  'mediumpurple': [255, 147, 112, 219],
  'mediumseagreen': [255, 60, 179, 113],
  'mediumslateblue': [255, 123, 104, 238],
  'mediumspringgreen': [255, 0, 250, 154],
  'mediumturquoise': [255, 72, 209, 204],
  'mediumvioletred': [255, 199, 21, 133],
  'midnightblue': [255, 25, 25, 112],
  'mintcream': [255, 245, 255, 250],
  'mistyrose': [255, 255, 228, 225],
  'moccasin': [255, 255, 228, 181],
  'navajowhite': [255, 255, 222, 173],
  'navy': [255, 0, 0, 128],
  'oldlace': [255, 253, 245, 230],
  'olive': [255, 128, 128, 0],
  'olivedrab': [255, 107, 142, 35],
  'orange': [255, 255, 165, 0],
  'orangered': [255, 255, 69, 0],
  'orchid': [255, 218, 112, 214],
  'palegoldenrod': [255, 238, 232, 170],
  'palegreen': [255, 152, 251, 152],
  'paleturquoise': [255, 175, 238, 238],
  'palevioletred': [255, 219, 112, 147],
  'papayawhip': [255, 255, 239, 213],
  'peachpuff': [255, 255, 218, 185],
  'peru': [255, 205, 133, 63],
  'pink': [255, 255, 192, 203],
  'plum': [255, 221, 160, 221],
  'powderblue': [255, 176, 224, 230],
  'purple': [255, 128, 0, 128],
  'red': [255, 255, 0, 0],
  'rosybrown': [255, 188, 143, 143],
  'royalblue': [255, 65, 105, 225],
  'saddlebrown': [255, 139, 69, 19],
  'salmon': [255, 250, 128, 114],
  'sandybrown': [255, 244, 164, 96],
  'seagreen': [255, 46, 139, 87],
  'seashell': [255, 255, 245, 238],
  'sienna': [255, 160, 82, 45],
  'silver': [255, 192, 192, 192],
  'skyblue': [255, 135, 206, 235],
  'slateblue': [255, 106, 90, 205],
  'slategray': [255, 112, 128, 144],
  'slategrey': [255, 112, 128, 144],
  'snow': [255, 255, 250, 250],
  'springgreen': [255, 0, 255, 127],
  'steelblue': [255, 70, 130, 180],
  'tan': [255, 210, 180, 140],
  'teal': [255, 0, 128, 128],
  'thistle': [255, 216, 191, 216],
  'tomato': [255, 255, 99, 71],
  'transparent': [0, 255, 255, 255],
  'turquoise': [255, 64, 224, 208],
  'violet': [255, 238, 130, 238],
  'wheat': [255, 245, 222, 179],
  'white': [255, 255, 255, 255],
  'whitesmoke': [255, 245, 245, 245],
  'yellow': [255, 255, 255, 0],
  'yellowgreen': [255, 154, 205, 50],
};
