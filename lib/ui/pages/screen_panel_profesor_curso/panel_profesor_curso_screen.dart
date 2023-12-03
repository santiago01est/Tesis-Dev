import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PanelProfesorCursoScreen extends StatefulWidget {
  const PanelProfesorCursoScreen({super.key});

  @override
  State<PanelProfesorCursoScreen> createState() =>
      _PanelProfesorCursoScreenState();
}

class _PanelProfesorCursoScreenState extends State<PanelProfesorCursoScreen> {
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final cursoCubit = context.watch<CursoCubit>();
    return Scaffold(
        backgroundColor: blueColor,
        appBar: const AppBarProfesor(),
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            TitleText(
              text: cursoCubit.state.nombre!,
            ),
            const SizedBox(height: 20),
            //buton
            ElevatedButton(
                onPressed: () {
                  router.go('/crearactividad');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Iniciar Nivel',
                )),

            LayoutBuilder(
              builder: (context, constraints) {
                // Verifica el ancho de la pantalla
                if (constraints.maxWidth > 700) {
                  // Pantalla grande: utiliza una fila
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCard(cursoCubit.state.descripcion ?? ''),
                      buildCardWithImageAndGraph(),
                    ],
                  );
                } else {
                  // Pantalla pequeña: utiliza una columna
                  return Column(
                    children: [
                      buildCard('Card 1'),
                      SizedBox(height: 20),
                      buildCardWithImageAndGraph(),
                    ],
                  );
                }
              },
            ),
          ]),
        ));
  }

  Widget buildCard(String descripcion) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          child: Padding(
            padding:
                const EdgeInsets.all(16), // Ajusta el padding del contenido
            child: Column(
              children: [
                SubtitleText(
                  text: 'Descripción del curso',
                ),
                ParagraphText(text: descripcion),
                // Agrega cualquier contenido adicional que desees aquí
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardWithImageAndGraph() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Imagen a la izquierda
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/tu_imagen.png'),
                  ),
                  // Gráfica circular a la derecha
                  Container(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: 0.7, // Puedes ajustar este valor
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
              // Agrega cualquier contenido adicional que desees aquí
            ],
          ),
        ),
      ),
    );
  }
}
