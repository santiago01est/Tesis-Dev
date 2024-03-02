// ignore: file_names
import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/radio_respuestas_estudio_creacion.dart';
import 'package:flutter/material.dart';

class CrearActividad extends StatefulWidget {
  const CrearActividad({super.key});

  @override
  _CrearActividadState createState() => _CrearActividadState();
}

class _CrearActividadState extends State<CrearActividad> {
  List<String> elements = [
    'boycampoderecha.png',
    'boytemploderecha.png',
    'cofre.png',
    'llave 1.png',
    'trigo.png',
    'pilar 1.png',
    'piedra 1.png'
  ];

  List<String> opciones = [
    'Avanzar.png',
    'GirarIzq.png',
    'GirarDerecha.png',
   
  ];

  List<List<String>> imagesList = [[], [], [], []]; // Elementos en cada tarjeta
  int _selectedOptionIndex = -1; // Index of the selected card

  late List<int> board;

  // Constructor
  _CrearActividadState() {
    board =
        List.generate(36, (index) => -1); // Inicializa con valores negativos
  }

  final TextEditingController descripcionTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                      ? MediaQuery.of(context).size.width / 3
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
                                padding:
                                    const EdgeInsets.only(left: 40, top: 20),
                                child: PixelLargeBttn(
                                  path: 'assets/items/ButtonBlue.png',
                                  onPressed: () {
                                    setState(() {
                                      board = List.generate(
                                          36,
                                          (index) =>
                                              -1); // Restablece la matriz en blanco
                                    });
                                  },
                                  text: 'Limpiar Tablero',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Lista de elementos arrastrables
                              Wrap(
                                children: opciones
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => Draggable(
                                        data: entry.value,
                                        feedback: Image.asset(
                                          'assets/buttons/${entry.value}',
                                          width: 80,
                                          height: 80,
                                        ),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          child: Center(
                                            child: Image.asset(
                                               'assets/buttons/${entry.value}',
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(
                                  imagesList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                                              return Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                elevation: 6,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.start,
                                                    spacing:
                                                        8.0, // Espacio entre las imágenes
                                                    runSpacing: 8.0,
                                                    children: List.generate(
                                                      imagesList[index].length,
                                                      (imgIndex) => Image.asset(
                                                         'assets/buttons/${imagesList[index][imgIndex]}',
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            onWillAccept: (data) => true,
                                            onAccept: (data) {
                                              setState(() {
                                                imagesList[index].add(data!);
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
            height: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20),

            decoration: BoxDecoration(
              color: orangeColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: // Lista de elementos
                Column(
              children: [
                const SizedBox(height: 50),
                const TitleText(text: 'Elementos'),
                const SizedBox(height: 40),
                const ParagraphText(
                    text:
                        'Arrastra y suelta los elementos al Mapa para construir la actividad'),
                const SizedBox(height: 20),
                Wrap(
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