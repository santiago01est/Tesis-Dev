import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/components/cards/curso_cards.dart';
import 'package:flutter/material.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/model/curso.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();

  @override
  Widget build(BuildContext context) {
    //implementar caso de uso de cursos
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
                                        router.go('/iniciosesion');
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
            Container(
              //color: Colors.blue,
              // padding: EdgeInsets.all(20.0),
              child: Column(
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
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent:
                                        300, // Tamaño máximo de cada card
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio:
                                        1, // Relación de aspecto para mantener cuadradas las cards
                                  ),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CursoCard(
                                      curso: snapshot.data![
                                          index], // Convertir el objeto Curso a un mapa
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      //
                    )),
                  ),
                  // Agrega otros widgets según sea necesario en la segunda sección
                ],
              ),
            ),

            const SizedBox(height: 30),
            // Barra de búsqueda redondeada
          ],
        ),
      ),
    );
  }
}
