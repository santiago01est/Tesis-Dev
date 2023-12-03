import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/components/cards/curso_cards.dart';
import 'package:flutter/material.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  void initState() {
    super.initState();
    // si el cubit no tiene datos, los obtiene
    if (context.read<BDCursosCubit>().state.isEmpty) {
      _fetchCursos();
    }
  }

  void _fetchCursos() async {
    try {
      final cursos = await cursosCasoUso.getCursos();
      context.read<BDCursosCubit>().subirCursos(cursos);
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Scaffold(
        backgroundColor: blueColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/FondoHome.png'), // Ruta de tu imagen de fondo
                    fit: BoxFit.cover, // Ajuste para cubrir el contenedor
                  ),
                ),

                // Contenido superpuesto en la primera sección
                child: Column(
                  children: [
                    // Fila con botón en la parte superior derecha
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 200,
                          height: 100,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: PixelLargeBttn(
                            path: 'assets/items/bttn_registrar.png',
                            onPressed: () {
                              router.go('/iniciosesion');
                            },
                          ),
                        )
                      ],
                    ),

                    // Fila con dos secciones
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sección de la izquierda con texto y botón
                          const Text(
                            'Mundo PC',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                              'Nos emociona tenerte a bordo en este emocionante viaje hacia el mundo del pensamiento computacional. Mundo PC es más que una plataforma; somos un puente entre la innovación, la creatividad y la enseñanza.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              )),
                          Container(
                            width: 200,
                            child: PixelLargeBttn(
                              path: 'assets/items/bttn_iniciar_sesion.png',
                              onPressed: () {
                                router.go('/registroprofesor');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    // Sección de la derecha con imagen

                    Image.asset(
                      'assets/ImagenMascotasHome.png',
                      fit: BoxFit.contain,
                      width: 400,
                    ),
                  ],
                ),
              ),
              Container(
                // padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Barra de búsqueda redondeada
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
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
                          widthFactor: 0.8,
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
                                        childAspectRatio: 0.5,
                                      ),
                                      itemCount: cursos.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return CursoCard(
                                          curso: cursos[index],
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
