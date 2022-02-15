import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifiedEnglishText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final bool? isShadowsOn;

  const ModifiedEnglishText(
      {this.color,
      this.size,
      required this.text,
      Key? key,
      this.isShadowsOn = false})
      : super(key: key);

  const ModifiedEnglishText.withShadows(
      {Key? key,
      required this.text,
      this.color,
      this.size,
      this.isShadowsOn = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isShadowsOn!) {
      return Text(
        text,
        style: GoogleFonts.breeSerif(
          color: color,
          fontSize: size,
          height: 0.9,
          shadows: <Shadow>[
            const Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 3.0,
              color: Colors.black,
            ),
            const Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 8.0,
              color: Color.fromARGB(125, 0, 0, 255),
            ),
          ],
        ),
      );
    } else {
      return Text(
        text,
        style: GoogleFonts.breeSerif(
          color: color,
          fontSize: size,
          height: 0.9,
        ),
      );
    }
  }
}
