import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';

class PixelLargeBttn extends StatelessWidget {
  final String path;
  final VoidCallback onPressed;
  final String text;

  const PixelLargeBttn(
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
        width: MediaQuery.of( context).size.width > 700 ? 200 : 140,
        height: MediaQuery.of( context).size.width > 700 ? 80 : 50,
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
