import 'package:dev_tesis/components/buttons/pixel_large_bttn.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                    margin: EdgeInsets.symmetric(horizontal: 10),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
