import 'package:flutter/material.dart';

class RadioRespuestasCuestionario extends StatefulWidget {
  final List<List<String>> imagesList;

  const RadioRespuestasCuestionario({Key? key, required this.imagesList})
      : super(key: key);

  @override
  _RadioRespuestasCuestionarioState createState() =>
      _RadioRespuestasCuestionarioState();
}

class _RadioRespuestasCuestionarioState
    extends State<RadioRespuestasCuestionario> {
  int _selectedOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        widget.imagesList.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0, // Espacio entre las imágenes
                      runSpacing: 8.0,

                      children: List.generate(
                        widget.imagesList[index].length,
                        (imgIndex) => Image.asset(
                          'assets/buttons/${
                          widget.imagesList[index][imgIndex]}',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
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
