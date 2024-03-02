import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';

class PixelSquareBttn extends StatelessWidget {
  final String path;
  final VoidCallback onPressed;
  final String text;

  const PixelSquareBttn(
      {Key? key,
      required this.path,
      required this.onPressed,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: MediaQuery.of( context).size.width > 700 ? 100 : 50,
        height: MediaQuery.of( context).size.width > 700 ? 100 : 50,
        child: GestureDetector(
          onTap: onPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                path,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SubtitleText(text: text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
