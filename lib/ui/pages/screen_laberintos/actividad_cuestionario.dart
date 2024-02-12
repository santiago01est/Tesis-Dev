import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/casilla.dart';
import 'package:dev_tesis/game/components/player.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/banner_info_actividades.dart';
import 'package:dev_tesis/ui/widgets/banner_instrucciones.dart';
import 'package:dev_tesis/ui/widgets/radio_respuestas_cuestionario.dart';
import 'package:dev_tesis/ui/widgets/response_game_flame.dart';
import 'package:dev_tesis/ui/widgets/tablero_cuestionario.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActividadCuestionarioScreen extends StatefulWidget {
  const ActividadCuestionarioScreen({super.key});

  @override
  State<ActividadCuestionarioScreen> createState() =>
      _ActividadCuestionarioScreenState();
}

class _ActividadCuestionarioScreenState
    extends State<ActividadCuestionarioScreen> {
  @override
  Widget build(BuildContext context) {
    ActividadCuestionario actividadCuestionario = ActividadCuestionario(
      id: "1",
      nombre: "Cuestionario 1",
      descripcion: "Descripción del cuestionario",
      estado: 'Activa',
      tipoActividad: "Cuestionario",
      dimension: 6,
      casillaFinal: 3,
      casillaInicio: 0,
      casillas: [
        Casilla(
          id: "1",
          numeroCasillas: [12],
          tipoCasilla: "Inicio",
          recurso: "avatares/granjeroboy_avatar.png",
        ),
        Casilla(
          id: "2",
          numeroCasillas: [16],
          tipoCasilla: "Final",
          recurso: "items/bulto_cafe.png",
        ),
        Casilla(
          id: "3",
          numeroCasillas: [3, 4, 5, 7, 8, 23, 28],
          tipoCasilla: "obstaculo",
          recurso: "items/planta.png",
        ),
        // Otras casillas...
      ],
      respuestaA: [
        'derecha',
        'derecha',
        'derecha',
        'derecha',
        'derecha',
        'derecha',
        'derecha',
        'derecha',
        'derecha'
      ],
      respuestaB: ['izquierda', 'izquierda', 'izquierda'],
      respuestaC: ['arriba', 'arriba', 'arriba'],
      respuestaD: ['abajo', 'abajo', 'abajo'],
    );
    return Scaffold(
      appBar: const CustomAppBar(userName: 'usuario'),
      // Responsive UI design for desktop and mobile
      body: MediaQuery.of(context).size.width > 700
          ? Container(
              color: blueColor,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const IntrinsicHeight(
                              child: BannerInfoActividades(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: BannerInstruccionesActividad(
                                  texto:
                                      'Ayuda a Juan a encontrar el camino al saco de café que ha recolectado',
                                  rutaEjemplo:
                                      'items/ejemplosImg/ejemplo_simple_secuencia.png'),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Add content for the left section of the blue board
                                        TableroCuestionario(
                                            actividadCuestionario:
                                                actividadCuestionario),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, bottom: 20),
                                          child: const Text(
                                            "Selecciona la mejor respuesta para llegar a la meta:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          child: RadioRespuestasCuestionario(
                                            imagesList: [
                                              actividadCuestionario.respuestaA,
                                              actividadCuestionario.respuestaB,
                                              actividadCuestionario.respuestaC,
                                              actividadCuestionario.respuestaD
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: blueColor,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
    );
  }

  void _mostrarDialogoVictoria(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Haz llegado a la meta'),
          content: Text(
              'El granjero ha encontrado a sus GALLINAS y esta muy agradecido contigo, !te ha dado un cafeto como recompensa!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                // Lógica para limpiar las instrucciones
                context.read<InstruccionesCubit>().limpiarInstrucciones();
              },
              child: Text('Seguir aprendiendo'),
            ),
          ],
        );
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const CustomAppBar({Key? key, required this.userName}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Mundo PC'),
      actions: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Opción 1'),
                value: 'Opción 1',
              ),
              PopupMenuItem(
                child: Text('Opción 2'),
                value: 'Opción 2',
              ),
              // Add more PopupMenuItems as needed
            ];
          },
          onSelected: (value) {
            // Handle selection
          },
        ),
      ],
    );
  }
}
