import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/PopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LayoutUnidadCurso extends StatefulWidget {
  final List<Unidad> unidades;

  const LayoutUnidadCurso({Key? key, required this.unidades}) : super(key: key);

  @override
  State<LayoutUnidadCurso> createState() => _LayoutUnidadCursoState();
}

class _LayoutUnidadCursoState extends State<LayoutUnidadCurso> {
  void eliminarActividad(int unidadIndex, int actividadIndex) {
    // Elimina la actividad del listado de actividades de la unidad
    widget.unidades[unidadIndex].actividades!.removeAt(actividadIndex);
    // Notifica a Flutter que los datos han cambiado y la interfaz de usuario necesita actualizarse
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rolCubit = context.watch<RolCubit>();
    final router = GoRouter.of(context);
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
                    itemCount: widget.unidades.length,
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
                                      text: widget.unidades[index].nombre!,
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
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    widget.unidades[index].actividades!.length,
                                itemBuilder: (context, activityIndex) {
                                  return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      color: Colors.white,
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (widget
                                                  .unidades[index]
                                                  .actividades![activityIndex]
                                                  .tipoActividad ==
                                              "Laberinto") {
                                            router.go('/laberinto');
                                          } else if (widget
                                                  .unidades[index]
                                                  .actividades![activityIndex]
                                                  .tipoActividad ==
                                              "Cuestionario") {
                                            router.go('/cuestionario');
                                          } else {}
                                        },
                                        child: ListTile(
                                            leading: Icon(Icons.hexagon,
                                                color: blueDarkColor),
                                            title: Text(widget
                                                .unidades[index]
                                                .actividades![activityIndex]
                                                .nombre!),
                                            trailing: rolCubit.state == 'profesor' // Verifica si el rol es igual a 'profesor'
      ? IconButton(
          icon: Icon(Icons.delete, color: orangeColor),
          onPressed: () {
            PopupUtils.showDeleteConfirmationDialog(context, () {
              // Lógica para eliminar la actividad
              eliminarActividad(index, activityIndex);
            });
          },
        )
      : SizedBox(), ),
                                      ));
                                },
                              ),
                              //Boton
                              SizedBox(height: 10),
                              rolCubit.state == 'profesor'  ?
                              PixelLargeBttn(
                                  path: 'assets/items/ButtonBlue.png',
                                  onPressed: () {
                                    router.go('/estudiocuestionario');
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
