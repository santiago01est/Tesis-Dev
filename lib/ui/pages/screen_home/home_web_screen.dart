import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/cards/curso_cards.dart';
import 'package:flutter/material.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/model/curso.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();
  final ProfesorCasoUso profesorCasoUso = getIt<ProfesorCasoUso>();

  @override
  void initState() {
    super.initState();
    // si el cubit no tiene datos, los obtiene
    if (context.read<BDCursosCubit>().state.isEmpty) {
      _fetchCursos();
      _fetchProfesores();
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
    //implementar caso de uso de cursos
    final router = GoRouter.of(context);
    final profesoresCubit = context.watch<ProfesoresCubit>();
    List<Profesor> profesores = profesoresCubit.state;
    return Scaffold(
      backgroundColor: blueColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/FondoHome.png'), // Ruta de tu imagen de fondo
                  fit: BoxFit.cover, // Ajuste para cubrir el contenedor
                ),
              ),
              child: Column(
                children: [
                  // Contenido superpuesto en la primera sección
                  Column(
                    children: [
                      // Fila con botón en la parte superior derecha
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 250,
                            height: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: PixelLargeBttn(
                              path: 'assets/items/bttn_iniciar_sesion.png',
                              onPressed: () {
                                router.go('/iniciosesion');
                              },
                            ),
                          )
                        ],
                      ),

                      // Fila con dos secciones
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Row(
                          children: [
                            // Sección de la izquierda con texto y botón
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Mundo PC',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  const Text(
                                      'Nos emociona tenerte a bordo en este emocionante viaje hacia el mundo del pensamiento computacional. Mundo PC es más que una plataforma; somos un puente entre la innovación, la creatividad y la enseñanza.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  const SizedBox(height: 20.0),
                                  Container(
                                    width: 250,
                                    height: 100,
                                    child: PixelLargeBttn(
                                      path: 'assets/items/bttn_registrar.png',
                                      onPressed: () {
                                        router.go('/registroprofesor');
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Sección de la derecha con imagen
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/ImagenMascotasHome.png',
                                    fit: BoxFit.contain,
                                    width: 500,
                                    height: 500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Segunda sección con fondo azul
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            // Icono de lupa
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                            // Campo de texto de búsqueda
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Buscar Curso...',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: BlocBuilder<BDCursosCubit, List<Curso>>(
                        builder: (context, cursos) {
                          if (cursos.isEmpty) {
                            return const CircularProgressIndicator();
                          } else {
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: cursos.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        router.go(
                                            '/panelprofesorcurso/${cursos[index].id}');
                                      },
                                      child: CursoCard(
                                        curso: cursos[index],
                                        nombreProfesor: obtenerNombreProfesor(
                                            profesores,
                                            cursos[index].profesor!),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                // Agrega otros widgets según sea necesario en la segunda sección
              ],
            ),

            const SizedBox(height: 30),
            // Barra de búsqueda redondeada
          ],
        ),
      ),
    );
  }

  obtenerNombreProfesor(List<Profesor> profesores, String idProfesor) {
    print(profesores.length);
    print('profesorid: $idProfesor');
    // for que retorna el nombre del profesor
    for (var i = 0; i < profesores.length; i++) {
      if (profesores[i].id == idProfesor) {
        return profesores[i].nombre;
      }
    }
    return '';
  }
}
