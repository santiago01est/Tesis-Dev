import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  final Widget dataWidget;
  const MobileLayout({Key? key, required this.dataWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        SizedBox(
          width: 350,
          child: dataWidget,
        )
      ]),
    );
  }
}
