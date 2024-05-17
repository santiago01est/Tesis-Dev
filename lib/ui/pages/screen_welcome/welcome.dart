import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/carrusel/carrusel_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
 late Future<void> _cursosProfesoresCasoUso;
  bool _isLoading = true;
  bool _isInitialized = false; // Variable para controlar el estado de carga


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Esto es una dependencia');
    if (!_isInitialized) {
      print('Inicializando...');
      _cursosProfesoresCasoUso = _initializeData();
      _isInitialized = true;
    }
  }

  Future<void> _initializeData() async {
    final initData = InitData(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );
    
      await initData.obtenerCursosYProfesores();
    
    _simularCarga();
  }

  void _simularCarga() {
    // Simular una carga de 5 segundos
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Indicador de carga
            )
          : Stack(
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
