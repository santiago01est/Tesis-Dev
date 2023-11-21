import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/components/cards/curso_cards.dart';
import 'package:flutter/material.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:go_router/go_router.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
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
                                router.go('/iniciosesion');
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
                        child: FutureBuilder<List<Curso>>(
                          future: cursosCasoUso.getCursos(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No hay cursos disponibles');
                            } else {
                              // Mostrar la lista de cursos utilizando snapshot.data
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CursoCard(
                                      curso: snapshot.data![
                                          index], // Convertir el objeto Curso a un mapa
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                        //
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
