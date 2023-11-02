import 'package:flutter/material.dart';

class PixelLargeBttn extends StatelessWidget {
  final String path;
  final VoidCallback onPressed;

  const PixelLargeBttn({Key? key, required this.path, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: IconButton(
        onPressed: onPressed,
        iconSize: 100,
        icon: Image.asset(path),
      ),
    );
  }
}
