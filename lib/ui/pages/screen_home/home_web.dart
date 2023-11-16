import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/components/cards/curso_cards.dart';
import 'package:flutter/material.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';

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

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/home.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Contenido del Scaffold
          // Scrollable
          SingleChildScrollView(
            child: Column(
              children: [
                // Botón en la parte superior derecha
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 300,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: PixelLargeBttn(
                      path: 'assets/items/bttn_iniciar_sesion.png',
                      onPressed: () {
                        print('Botón presionado');
                      },
                    ),
                  ),
                ),

                // Imagen desde los assets
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'assets/items/mascota_dialogo.png',
                    width: 600,
                    height: 400,
                  ),
                ),
                // Barra de búsqueda redondeada
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
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
                    widthFactor: 0.5,
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
                                itemBuilder: (BuildContext context, int index) {
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
