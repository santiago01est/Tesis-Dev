import 'dart:math';

import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/actividad_custio_test.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_small_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class CrearActividad extends StatefulWidget {
  final int unidadId;
  const CrearActividad({super.key, required this.unidadId});

  @override
  CrearActividadState createState() => CrearActividadState();
}

class CrearActividadState extends State<CrearActividad> {
  List<String> elements = [
    'boycampoderecha.png', // 0
    'boycampofrente.png', // 1
    'boytemploderecha.png', // 2
    'pollitoUnidad0.png', // 3
    'cofre.png', // 4
    'llave 1.png', // 5
    'sacocafe.png', // 6
    'florUnidad0.png', // 7
    'gemaAmarilla.png', // 8
    'gemaAzul.png', // 9
    'gemaRoja.png', // 10
    'gemaVerde.png', // 11
    'gallinas.png', // 12
    'gallinaUnidad0.png', // 13
    'huevo.png', // 14
    'trigo.png', // 15
    'calabaza.png', // 16
    'pilar 1.png', // 17
    'pilarfuego.png', // 18
    'piedra 1.png', // 19
    'cajas.png', // 20
    'jarrones.png', // 21
    'abeja.png', // 22
    'gatoUnidad0.png', // 23
    'trigocosecha.png', // 24
    'arbol.png', // 25
    'arbolmandarino.png', // 26
    'canasta.png', // 27
    'cerdito.png', // 28
    'corralcerditos.png', // 29
    'fuego.png', // 30
  ];

  List<String> opciones = [
    'Avanzar.png',
    'GirarIzq.png',
    'GirarDerecha.png',
    'Agarrar.png',
    'DosAvanzar.png',
    'TresAvanzar.png',
    'CuatroAvanzar.png',
    'DosGiroIzq.png',
    'DosGiroDerecha.png',
    'DosComboGiroDerecha.png',
    'DosComboGiroIzq.png',
    'DosComboGiroDerechaAvanzar.png',
    'DosComboGiroIzqAvanzar.png',
  ];

  // Opciones de las habilidades seleccionadas
  final List<int> _selectedOptions = List.generate(4, (_) => 0);
  final List<String> _selectedOptionsText = [
    'Patrones',
    'Descomposición',
    'Abstracción',
    'Algoritmos'
  ];

  void _handleOptionChange(int index) {
    setState(() {
      // Si la opción está seleccionada, cambiar a no seleccionada; de lo contrario, cambiar a seleccionada
      _selectedOptions[index] = _selectedOptions[index] == 0 ? 1 : 0;
    });
  }

  List<List<String>> imagesList = [[], [], [], []]; // Elementos en cada tarjeta
  int _selectedOptionIndex = -1; // Index of the selected card

// lista del tablero a dibujar
  List<int> board = List.generate(36, (index) => -1);

  // Lista de pesos de la actividad en el orden de las tarjetas
  List<int> pesos = List.generate(4, (index) => 1);

  final TextEditingController descripcionTextEditingController =
      TextEditingController();

  List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final unidadesCubit =
        context.read<UnidadesCubit>().obtenerUnidadPorId(widget.unidadId);

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
                                const SizedBox(height: 20),
                              ])),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 50, top: 20),
                                child: SubtitleText(
                                    text: 'Descripción de la Actividad'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, top: 20),
                                child: TextFormField(
                                  maxLines: null,
                                  controller: descripcionTextEditingController,
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
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          color: _selectedOptions[i] == 1
                                              ? Colors.blue
                                              : null,
                                          child: InkWell(
                                            onTap: () => _handleOptionChange(i),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Center(
                                                child: Text(
                                                  _selectedOptionsText[i],
                                                  style: TextStyle(
                                                    color:
                                                        _selectedOptions[i] == 1
                                                            ? Colors.white
                                                            : null,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
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
                                        for (int i = 0;
                                            i < _controllers.length;
                                            i++) {
                                          pesos[i] =
                                              int.parse(_controllers[i].text);
                                        }
                                        ActividadCuestionario
                                            actividadCuestionarioSave =
                                            ActividadCuestionario(
                                                id: Random().nextInt(1000),
                                                nombre: 'Diagnostico',
                                                descripcion:
                                                    descripcionTextEditingController
                                                        .text,
                                                estado: 'Activo',
                                                tipoActividad: 'Cuestionario',
                                                dimension: 6,
                                                habilidades: _selectedOptions,
                                                casillas: board,
                                                pista: '',
                                                respuestas: imagesList,
                                                ejercicioImage: '',
                                                ejemploImage:
                                                    'ejemplocuestionarioU2CiclosAgarrar.png',
                                                pesoRespuestas: pesos,
                                                respuestaCorrecta:
                                                    _selectedOptionIndex);

                                        

                                        CursosCasoUso cursosCasoUso= CursosCasoUso(cursoRepository:  getIt<CursoRepository>(), context: context);

                                        cursosCasoUso.agregarActividad(
                                            unidadesCubit!.cursoId,
                                            actividadCuestionarioSave, widget.unidadId);
                                                
                                        

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
                                                        'Actv: ${unidadesCubit!.actividades!.firstWhere(
                                                              (actividad) =>
                                                                  actividad
                                                                      .id ==
                                                                  actividadCuestionarioSave
                                                                      .id,
                                                            ).toString()}'),

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
                                  runSpacing: 10,
                                  children: opciones
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => Draggable(
                                          data: entry.value,
                                          feedback: Image.asset(
                                            'assets/buttons/${entry.value}',
                                            width: entry.value ==
                                                        'Avanzar.png' ||
                                                    entry.value ==
                                                        'GirarIzq.png' ||
                                                    entry.value ==
                                                        'GirarDerecha.png' ||
                                                    entry.value == 'Agarrar.png'
                                                ? 50
                                                : 120,
                                            height: 50,
                                          ),
                                          child: Container(
                                            width: entry.value ==
                                                        'Avanzar.png' ||
                                                    entry.value ==
                                                        'GirarIzq.png' ||
                                                    entry.value ==
                                                        'GirarDerecha.png' ||
                                                    entry.value == 'Agarrar.png'
                                                ? 50
                                                : 120,
                                            height: 50,
                                            child: Center(
                                              child: Image.asset(
                                                'assets/buttons/${entry.value}',
                                                width: entry.value ==
                                                            'Avanzar.png' ||
                                                        entry.value ==
                                                            'GirarIzq.png' ||
                                                        entry.value ==
                                                            'GirarDerecha.png' ||
                                                        entry.value ==
                                                            'Agarrar.png'
                                                    ? 50
                                                    : 120,
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(height: 12),
                                // Tarjeta con un TextField y un DragTarget

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
                                            // indice de la opcion de respuesta
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
                                                                height: 50,
                                                                width: imagesList[index][imgIndex] == 'Avanzar.png' ||
                                                                        imagesList[index][imgIndex] ==
                                                                            'GirarIzq.png' ||
                                                                        imagesList[index][imgIndex] ==
                                                                            'GirarDerecha.png' ||
                                                                        imagesList[index][imgIndex] ==
                                                                            'Agarrar.png'
                                                                    ? 50
                                                                    : 120,
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
                                                            _controllers[index],
                                                        initialValue: 1,
                                                        min: 1,
                                                        max: 4,
                                                        onChanged: (value) {
                                                          _controllers[index]
                                                                  .text =
                                                              value.toString();
                                                        },
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