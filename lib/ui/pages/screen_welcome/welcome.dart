import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/carrusel/carrusel_welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class welcome extends StatefulWidget {
  welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();
  final ProfesorCasoUso profesorCasoUso = getIt<ProfesorCasoUso>();

  @override
  void initState() {
    super.initState();
    // si el cubit no tiene datos, los obtiene
    if (context.read<BDCursosCubit>().state.isEmpty) {
      _fetchCursos();
      _fetchProfesores();
      //_fetchProfesores();
    }
  }

  Future<void> _fetchCursos() async {
    try {
      final cursos = await cursosCasoUso.getCursos();
      context.read<BDCursosCubit>().subirCursos(cursos);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  void _fetchProfesores() async {
    try {
      final profesores = await profesorCasoUso.getProfesores();
      context.read<ProfesoresCubit>().subirProfesores(profesores);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

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
