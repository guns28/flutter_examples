import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({ required Key key,
    required this.photo,
    required this.onTap,
    required this.height,
    required this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  final double height;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
