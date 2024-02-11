import 'package:flutter/material.dart';

void main() => runApp(CrearActividad());

class CrearActividad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tablero 6x6'),
        ),
        body: BoardPage(),
      ),
    );
  }
}

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  List<String> elements = [
    'chico.png',
    'chica.png',
    'bus.png',
    'gato.png',
    'casillaAyuda.png'
  ];
  late List<int> board;

  // Constructor
  _BoardPageState() {
    board =
        List.generate(36, (index) => -1); // Inicializa con valores negativos
  }

  bool isChildOrBus(int elementIndex) {
    return elementIndex == 0 ||
        elementIndex == 2 ||
        elementIndex == 4; // Índices del niño y el autobús
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                          ? 'assets/${elements[elementIndex]}'
                          : 'assets/whiteCasilla.png',
                      width: 60,
                      height: 60,
                    ),
                    child: DragTarget<int>(
                      builder: (context, acceptedData, rejectedData) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: isChildOrBus(elementIndex)
                                ? Colors.green
                                : Colors.white,
                          ),
                          child: Center(
                            child: Image.asset(
                              elementIndex >= 0
                                  ? 'assets/${elements[elementIndex]}'
                                  : 'assets/whiteCasilla.png',
                              width: 60,
                              height: 60,
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
                    'assets/${entry.value}',
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
                        'assets/${entry.value}',
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
    );
  }
}
