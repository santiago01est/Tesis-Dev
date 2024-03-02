import 'package:flutter/material.dart';
class RadioRespuestasEstudio extends StatefulWidget {
  const RadioRespuestasEstudio({Key? key}) : super(key: key);

  @override
  _RadioRespuestasEstudioState createState() => _RadioRespuestasEstudioState();
}

class _RadioRespuestasEstudioState extends State<RadioRespuestasEstudio> {
  List<List<String>> imagesList = [
    [], // Lista para la carta A
    [], // Lista para la carta B
    [], // Lista para la carta C
    [], // Lista para la carta D
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        4,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                String.fromCharCode(65 + index) + ". ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DragTarget<String>(
                      onWillAccept: (data) => true,
                      onAccept: (data) {
                        setState(() {
                          imagesList[index].add(data); // Agrega la imagen arrastrada a la lista correspondiente
                        });
                      },
                      builder: (context, accepted, rejected) {
                        return Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.0, // Espacio entre las imágenes
                          runSpacing: 8.0,
                          children: imagesList[index].map((imgPath) {
                            return Draggable<String>(
                              data: imgPath,
                              child: Image.asset(
                                _getImagePath(imgPath),
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              feedback: Image.asset(
                                _getImagePath(imgPath),
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    imagesList[index].clear(); // Limpia la lista de imágenes de esta carta
                  });
                },
                child: Text('Limpiar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getImagePath(String direction) {
    // Implementa la lógica para obtener la ruta de la imagen según la dirección
    // Por ejemplo:
    switch (direction.toLowerCase()) {
      case 'arriba':
        return 'assets/buttons/Arriba.png';
      case 'derecha':
        return 'assets/buttons/Derecha.png';
      case 'abajo':
        return 'assets/buttons/Abajo.png';
      case 'izquierda':
        return 'assets/buttons/Izquierda.png';
      default:
        return 'assets/buttons/Play.png';
    }
  }
}