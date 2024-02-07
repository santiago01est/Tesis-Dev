import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutUnidadCurso extends StatelessWidget {
  final List<Unidad> unidades;

  const LayoutUnidadCurso({Key? key, required this.unidades}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    itemCount: unidades.length,
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
                                      text: unidades[index].nombre!,
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
                                itemCount: unidades[index].actividades!.length,
                                itemBuilder: (context, activityIndex) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.white,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        router.go('/laberinto');
                                      },
                                      child: ListTile(
                                          leading: Icon(Icons.hexagon,
                                              color: blueDarkColor),
                                          title: Text(unidades[index]
                                              .actividades![activityIndex]
                                              .nombre!),
                                          trailing: IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: orangeColor),
                                              onPressed: () {
                                                //eliminarEstudiante(index);
                                              })),
                                    ),
                                  );
                                },
                              ),
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
