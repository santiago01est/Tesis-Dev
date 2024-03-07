// ignore: file_names
import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/ui/bloc/actividad_custio_test.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_small_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class CrearActividad extends StatefulWidget {
  final String unidadId;
  const CrearActividad({super.key, required this.unidadId});

  @override
  CrearActividadState createState() => CrearActividadState();
}

class CrearActividadState extends State<CrearActividad> {
  List<String> elements = [
    'boycampoderecha.png',
    'boycampofrente.png',
    'boytemploderecha.png',
    'cofre.png',
    'llave 1.png',
    'sacocafe.png',
    'gemaAmarilla.png',
    'gemaAzul.png',
    'gemaRoja.png',
    'gemaVerde.png',
    'gallinas.png',
    'huevo.png',
    'trigo.png',
    'calabaza.png',
    'pilar 1.png',
    'pilarfuego.png',
    'piedra 1.png',
    'cajas.png',
    'jarrones.png',
    'abeja.png'
  ];

  List<String> opciones = [
    'Avanzar.png',
    'GirarIzq.png',
    'GirarDerecha.png',
    'Agarrar.png'
  ];

  List<List<String>> imagesList = [[], [], [], []]; // Elementos en cada tarjeta
  int _selectedOptionIndex = -1; // Index of the selected card

// lista del tablero a dibujar
  List<int> board = List.generate(36, (index) => -1);

  final TextEditingController descripcionTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Scaffold(
        appBar: AppBarProfesor(),
        body: Row(children: [
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50, bottom: 20),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TitleText(
                                    text:
                                        'Estudio de Creación Actividad Cuestionario'),
                                const SizedBox(height: 40),
                                const SubtitleText(
                                    text: 'Descripción de la Actividad'),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width > 700
                                      ? 600
                                      : MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    maxLines: null,
                                    controller:
                                        descripcionTextEditingController,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      hintText:
                                          "Ingresa la descripción para orientar a los estudiantes",
                                      prefixIcon: Icon(Icons.text_fields,
                                          color: blueColor),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      isDense: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      fillColor: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ])),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, top: 20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 600, // Tamaño del tablero
                                    height: 600, // Tamaño del tablero
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 6,
                                      ),
                                      itemCount: 36, // 6x6
                                      itemBuilder: (context, index) {
                                        final elementIndex = board[index];
                                        return Draggable(
                                          data: elementIndex,
                                          feedback: Image.asset(
                                            elementIndex >= 0
                                                ? 'assets/items/estudio/${elements[elementIndex]}'
                                                : 'assets/whiteCasilla.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                          child: DragTarget<int>(
                                            builder: (context, acceptedData,
                                                rejectedData) {
                                              return Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.white,
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    elementIndex >= 0
                                                        ? 'assets/items/estudio/${elements[elementIndex]}'
                                                        : 'assets/whiteCasilla.png',
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                ),
                                              );
                                            },
                                            onWillAccept: (data) {
                                              return board[index] == -1;
                                            },
                                            onAccept: (data) {
                                              setState(() {
                                                board[index] = data;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Wrap(
                                  children: [
                                    PixelSmallBttn(
                                      path: 'assets/items/ButtonBlue.png',
                                      onPressed: () {
                                        setState(() {
                                          board = List.generate(
                                              36,
                                              (index) =>
                                                  -1); // Restablece la matriz en blanco
                                        });
                                      },
                                      text: 'Limpiar',
                                    ),
                                    PixelSmallBttn(
                                      path: 'assets/items/ButtonOrange.png',
                                      onPressed: () {},
                                      text: 'Cancelar',
                                    ),
                                    PixelSmallBttn(
                                      path: 'assets/items/ButtonBlue.png',
                                      onPressed: () {
                                        ActividadCuestionario
                                            actividadCuestionarioSave =
                                            ActividadCuestionario(
                                                id: '123',
                                                nombre: 'ACTIVIDAD NUEVA',
                                                descripcion:
                                                    descripcionTextEditingController
                                                        .text,
                                                estado: 'Activo',
                                                tipoActividad: 'Cuestionario',
                                                dimension: 6,
                                                casillas: board,
                                                respuestas: imagesList,
                                                respuestaCorrecta:
                                                    _selectedOptionIndex);

                                        context.read<ActividadCuestionarioCubit>().addActividadCuestionario(actividadCuestionarioSave);
                                        context.read<UnidadesCubit>().addActividad(Actividad(id: actividadCuestionarioSave.id,nombre: actividadCuestionarioSave.nombre,descripcion: actividadCuestionarioSave.descripcion, estado: actividadCuestionarioSave.estado, tipoActividad: actividadCuestionarioSave.tipoActividad), widget.unidadId);

                                        // cerrar screen y volver

                                        
                                        /*
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Contenido de la actividad'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Nombre: ${actividadCuestionarioSave.nombre}'),
                                                    Text(
                                                        'Descripción: ${actividadCuestionarioSave.descripcion}'),
                                                        Text(
                                                        'Descripción: ${actividadCuestionarioSave.casillas}'),
                                                        Text(
                                                        'Descripción: ${actividadCuestionarioSave.respuestas}'),
                                                        Text(
                                                        'Descripción: ${actividadCuestionarioSave.respuestaCorrecta}'),
                                                    // Agrega más detalles de la actividad según sea necesario
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cerrar'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        */
                                        router.pop();
                                      },
                                      text: 'Publicar',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const ParagraphText(
                                    text:
                                        'Crea, selecciona la respuesta correcta y asignale una puntuación del 1 al 4'),
                                SizedBox(height: 8),
                                const ParagraphTextEnlace(
                                    text:
                                        'para más información sobre crear actividades clic aquí'),
                                SizedBox(height: 30),
                                // Lista de elementos arrastrables
                                Wrap(
                                  spacing: 10,
                                  children: opciones
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => Draggable(
                                          data: entry.value,
                                          feedback: Image.asset(
                                            'assets/buttons/${entry.value}',
                                            width: 40,
                                            height: 40,
                                          ),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            child: Center(
                                              child: Image.asset(
                                                'assets/buttons/${entry.value}',
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    imagesList.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Radio<int>(
                                            value: index,
                                            groupValue: _selectedOptionIndex,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedOptionIndex = value!;
                                              });
                                            },
                                          ),
                                          Text(
                                            String.fromCharCode(65 + index) +
                                                ". ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: DragTarget<String>(
                                              builder: (context, candidateData,
                                                  rejectedData) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        elevation: 6,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            spacing:
                                                                8.0, // Espacio entre las imágenes
                                                            runSpacing: 8.0,
                                                            children:
                                                                List.generate(
                                                              imagesList[index]
                                                                  .length,
                                                              (imgIndex) =>
                                                                  Image.asset(
                                                                'assets/buttons/${imagesList[index][imgIndex]}',
                                                                height: 40,
                                                                width: 40,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        icon: Icon(Icons.delete,
                                                            color: orangeColor),
                                                        onPressed: () {
                                                          setState(() {
                                                            imagesList[index]
                                                                .clear();
                                                          });
                                                        }),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child:
                                                          NumberInputPrefabbed
                                                              .leafyButtons(
                                                        controller:
                                                            TextEditingController(),
                                                        initialValue: 1,
                                                        min: 1,
                                                        max: 4,
                                                        incDecBgColor:
                                                            orangeColor,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                              onWillAccept: (data) => true,
                                              onAccept: (data) {
                                                setState(() {
                                                  imagesList[index].add(data);
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

// Cards Options
                  ],
                ),
              )),
          Expanded(
              child: Container(
            // ocupara el espacio disponible
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, right: 20),

            decoration: BoxDecoration(
              color: orangeColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: // Lista de elementos
                SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const TitleText(text: 'Elementos'),
                  const SizedBox(height: 40),
                  const ParagraphText(
                      text:
                          'Arrastra y suelta los elementos al Mapa para construir la actividad'),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 26,
                    children: elements
                        .asMap()
                        .entries
                        .map((entry) => Draggable(
                              data: entry.key,
                              feedback: Image.asset(
                                'assets/items/estudio/${entry.value}',
                                width: 80,
                                height: 80,
                              ),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: Image.asset(
                                    'assets/items/estudio/${entry.value}',
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ))
        ]));
  }
}


/*
 Row(
        children: <Widget>[
          // Tablero
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 600, // Tamaño del tablero
                height: 600, // Tamaño del tablero
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  itemCount: 36, // 6x6
                  itemBuilder: (context, index) {
                    final elementIndex = board[index];
                    return Draggable(
                      data: elementIndex,
                      feedback: Image.asset(
                        elementIndex >= 0
                            ? 'assets/items/estudio/${elements[elementIndex]}'
                            : 'assets/whiteCasilla.png',
                        width: 80,
                        height: 80,
                      ),
                      child: DragTarget<int>(
                        builder: (context, acceptedData, rejectedData) {
                          return Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Image.asset(
                                elementIndex >= 0
                                    ? 'assets/items/estudio/${elements[elementIndex]}'
                                    : 'assets/whiteCasilla.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                          );
                        },
                        onWillAccept: (data) {
                          return board[index] == -1;
                        },
                        onAccept: (data) {
                          setState(() {
                            board[index] = data;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Lista de elementos
          Column(
            children: elements
                .asMap()
                .entries
                .map(
                  (entry) => Draggable(
                    data: entry.key,
                    feedback: Image.asset(
                      'assets/items/estudio/${entry.value}',
                      width: 40,
                      height: 40,
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/items/estudio/${entry.value}',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                board = List.generate(
                    36, (index) => -1); // Restablece la matriz en blanco
              });
            },
            child: Text('Limpiar Tablero'),
          ),
        ],
      ),

*/