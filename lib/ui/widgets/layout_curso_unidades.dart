import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/PopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LayoutUnidadCurso extends StatefulWidget {
  const LayoutUnidadCurso({Key? key}) : super(key: key);

  @override
  State<LayoutUnidadCurso> createState() => _LayoutUnidadCursoState();
}

class _LayoutUnidadCursoState extends State<LayoutUnidadCurso> {

 bool _isLoading = true; // Estado de carga inicial
   @override
  void initState() {
    super.initState();
    // Escuchar cambios en el estado del cubit
    context.read<SeguimientoCubit>().stream.listen((state) {
      // Actualizar el estado de carga del widget cuando los datos estén cargados
      if (_isLoading && state.respuestasActividades != null) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

 Color getBackgroundColor(int activityIndex, Seguimiento seguimientoState) {
    // Verificar si hay un cero en la lista en el índice de la actividad
    if (seguimientoState.respuestasActividades != null &&
        seguimientoState.respuestasActividades![activityIndex] == 0) {
      // Si hay un cero, devolver gris
      return Colors.grey;
    } else {
      // Si no hay un cero, devolver verde
      return Colors.green;
    }
  }



  @override
  Widget build(BuildContext context) {
    final rolCubit = context.watch<RolCubit>();
    final router = GoRouter.of(context);
    final unidadesCubit = context.watch<UnidadesCubit>();
    final seguimientoCubit= context.watch<SeguimientoCubit>();
    



    void eliminarActividad(String idActividad) {
      // Elimina la actividad del listado de actividades de la unidad
      unidadesCubit.eliminarActividadDeUnidad(idActividad);

      // Notifica a Flutter que los datos han cambiado y la interfaz de usuario necesita actualizarse
      setState(() {});
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        // Mostrar la lista de unidades

        Expanded(
            child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 50),
            Padding(
                padding: EdgeInsets.all(0),
                child: Center(
                    child: FractionallySizedBox(
                  // si el ancho de la pantalla es menor a 700 es un dispositivo movil
                  widthFactor:
                      MediaQuery.of(context).size.width < 700 ? 0.8 : 0.6,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: unidadesCubit.state.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: index == 1 ? orangeColor : blueColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Primera fila
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Mini card con índice
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: TitleText(
                                      text: unidadesCubit.state[index].nombre!,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Imagen de la mascota
                                  Image.asset(
                                    //si el indice es uno se muestra una imagen si es diferente otra
                                    index == 1
                                        ? 'assets/avatares/perico_avatar.png'
                                        : 'assets/avatares/chiguiro_avatar.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Segunda fila con lista de actividades
                              Wrap(
                                spacing:
                                    8.0, // Espacio horizontal entre los elementos
                                runSpacing:
                                    8.0, // Espacio vertical entre las filas de elementos
                                children: List.generate(
                                  unidadesCubit
                                      .state[index].actividades!.length,
                                  (activityIndex) {
                                    return SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Card(
                                        elevation: 2,
                                        shadowColor:  Colors.grey ,
//llamada a la funcion del color de estado,

                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        color: Colors.white,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (unidadesCubit
                                                    .state[index]
                                                    .actividades![activityIndex]
                                                    .tipoActividad ==
                                                "Laberinto") {
                                              router.go(
                                                  '/laberinto/${unidadesCubit.state[index].actividades![activityIndex].id}');
                                            } else if (unidadesCubit
                                                    .state[index]
                                                    .actividades![activityIndex]
                                                    .tipoActividad ==
                                                "Cuestionario") {
                                              router.go(
                                                  '/cuestionario/${unidadesCubit.state[index].actividades![activityIndex].id}');
                                            }
                                          },
                                          child: Center(
                                            // Envuelve el Texto con un Widget Center
                                            child: Text(
                                              '${activityIndex + 1}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              //Boton
                              SizedBox(height: 10),
                              rolCubit.state == 'profesor'
                                  ? PixelLargeBttn(
                                      path: 'assets/items/ButtonBlue.png',
                                      onPressed: () {
                                        router.push(
                                            '/estudiocuestionario/${unidadesCubit.state[index].id}');
                                      },
                                      text: 'Crear Actividad')
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )))
          ]),
        ))
      ],
    );
  }
}
