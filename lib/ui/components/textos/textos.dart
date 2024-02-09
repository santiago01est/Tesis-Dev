import 'package:flutter/material.dart';

class LargeTitleText extends StatelessWidget {
  final String text;

  const LargeTitleText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class BigText extends StatelessWidget {
  final String text;

  const BigText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  //color para el texto
  final Color? color;

  const TitleText({required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black,
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class ParagraphText extends StatelessWidget {
  final String text;

  const ParagraphText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
