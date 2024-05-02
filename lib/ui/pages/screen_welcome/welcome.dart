import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/carrusel/carrusel_welcome.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late InitData _cursosProfesoresCasoUso;

  @override
  void initState() {
    super.initState();
    _cursosProfesoresCasoUso = InitData(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );
    _cursosProfesoresCasoUso.obtenerCursosYProfesores();
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fondos/FondoInicio.png',
            fit: BoxFit.cover,
          ),

          Positioned(
            right: 0,
            left: 0,
            top: 20,
            child: Center(
              child: Image.asset(
                width: 800,
                height: 200,
                'assets/logomundopc.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          //carrusel en el centro
          const Center(
              child: ImageCarousel(
            imagePaths: [
              "assets/PosterWelcome1.png",
              "assets/PosterWelcome2.png",
              "assets/PosterWelcome3.png",
              // Agrega más rutas de imágenes según sea necesario
            ],
          )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: PixelLargeBttn(
                path: 'assets/items/ButtonBlue.png',
                onPressed: () {
                  router.go('/inicio');
                },
                text: 'Empezar',
              )),
        ],
      ),
    );
  }
}
