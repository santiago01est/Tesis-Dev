import 'package:flutter/material.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  List<Map<String, String>> cursos = [
    {
      'nombre': 'Curso 1',
      'descripcion': 'Descripción del Curso 1',
      'profesor': 'Profesor del Curso 1',
      'imagen': 'assets/Inicio.png',
    },
    {
      'nombre': 'Curso 2',
      'descripcion': 'Descripción del Curso 2',
      'profesor': 'Profesor del Curso 2',
      'imagen': 'assets/Inicio.png',
    },
    {
      'nombre': 'Curso 3',
      'descripcion': 'Descripción del Curso 3',
      'profesor': 'Profesor del Curso 3',
      'imagen': 'assets/Inicio.png',
    },
    {
      'nombre': 'Curso 4',
      'descripcion': 'Descripción del Curso 4',
      'profesor': 'Profesor del Curso 4',
      'imagen': 'assets/Inicio.png',
    },
    {
      'nombre': 'Curso 5',
      'descripcion': 'Descripción del Curso 5',
      'profesor': 'Profesor del Curso 5',
      'imagen': 'assets/Inicio.png',
    },
    {
      'nombre': 'Curso 6',
      'descripcion': 'Descripción del Curso 6',
      'profesor': 'Profesor del Curso 6',
      'imagen': 'assets/Inicio.png',
    },
    {
      'nombre': 'Curso 7',
      'descripcion': 'Descripción del Curso 7',
      'profesor': 'Profesor del Curso 7',
      'imagen': 'assets/Inicio.png',
    },
  ];

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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                      child: FractionallySizedBox(
                          widthFactor: 0.5,
                          child: ListView(
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
                                itemCount: cursos.length, // Cantidad de cursos
                                itemBuilder: (BuildContext context, int index) {
                                  return CourseCard(
                                    curso: cursos[index],
                                  );
                                },
                              ),
                            ],
                          ))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, String> curso;

  const CourseCard({Key? key, required this.curso}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            curso['imagen']!,
            width: double.infinity,
            height: 100,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  curso['nombre']!, // Nombre del curso
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  curso['descripcion']!, // Descripción del curso
                ),
                Text(
                  'Profesor: ${curso['profesor']}', // Nombre del profesor
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
