import 'dart:ui';

class FontPalette {
  static const String primaryTextFont = 'FragileBombers';
  static const String titleTextFont = 'GoodTiming';

  static const Color damagedColor = Color(0xFFFF0000);

  /// Ship colors available for the player to choose from. This will be tinting the ship sprite with the selected color thanks to the decorator.
  static const List<Color> shipAvailableColors = [
    Color(0x00),
    Color(0x5500FF00),
    Color(0x550000FF),
    Color(0x55FF0000),
    Color(0x55FFFF00),
    Color(0x5500FFFF),
    Color(0x55FF00FF),
    Color(0x55FFFFFF),
  ];
}