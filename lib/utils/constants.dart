import 'package:flutter/material.dart';

// Vertical indent for UI
Widget verticalIndent() {
  return const SizedBox(
    height: 10,
  );
}

// Base URL for all images
const String baseUrlForImages = 'https://image.tmdb.org/t/p/w500';

// URL for background image on main screen
const String baseUrlForBackground =
    'https://funart.pro/uploads/posts/2020-04/1587215417_4-p-foni-dlya-prilozhenii-8.jpg';

// URL for unknown actor
const String unknownActorPhoto =
    'https://www.pngkey.com/png/full/21-213224_unknown-person-icon-png-download.png';

// Font Sizes for ModifiedText
class ModifiedTextFontSize {
  static double small = 14;
  static double medium = 18;
  static double large = 26;
}
