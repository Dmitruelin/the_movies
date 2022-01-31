import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key? key,
      required this.photo,
      required this.width,
      required this.onTap,
      required this.height})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
