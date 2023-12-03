import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/carrusel/carrusel_welcome.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/FondoInicio.png',
            fit: BoxFit.cover,
          ),

          const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Mundo PC',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))),
          //carrusel en el centro
          const Center(
              child: ImageCarousel(
            imagePaths: [
              "assets/PosterWelcome1.png",
              "assets/PosterWelcome2.png",
              "assets/FondoInicio.png",
              // Agrega más rutas de imágenes según sea necesario
            ],
          )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: PixelLargeBttn(
                    path: 'assets/items/Bttn.png',
                    onPressed: () {
                      router.go('/inicio');
                    })),
          ),
        ],
      ),
    );
  }
}
