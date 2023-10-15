import 'package:dev_tesis/components/buttons/pixel_large_bttn.dart';
import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/Inicio.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: PixelLargeBttn(
                    path: 'assets/items/Bttn.png',
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    })),
          ),
        ],
      ),
    );
  }
}
