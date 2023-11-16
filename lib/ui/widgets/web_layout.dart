import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  final Widget dataWidget;
  const WebLayout({Key? key, required this.dataWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(children: [
          SizedBox(
            width: 500,
            child: dataWidget,
          )
        ]),
      ),
    ]);
  }
}
