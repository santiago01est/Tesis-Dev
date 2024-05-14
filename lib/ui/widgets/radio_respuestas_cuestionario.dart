import 'package:flutter/material.dart';

class RadioRespuestasCuestionario extends StatefulWidget {
  final List<dynamic> imagesList;
  final Function(int) radioRespuesta;
  final int initialValue;

  const RadioRespuestasCuestionario(
      {Key? key,
      required this.imagesList,
      required this.radioRespuesta,
      required this.initialValue})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RadioRespuestasCuestionarioState createState() =>
      _RadioRespuestasCuestionarioState();
}

class _RadioRespuestasCuestionarioState
    extends State<RadioRespuestasCuestionario> {
  late int _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _selectedOptionIndex = widget.initialValue;
  }

  @override
  void dispose() {
    _selectedOptionIndex =
        widget.initialValue; // Reinicia el estado al desechar el widget
    super.dispose();
  }

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
                    widget.radioRespuesta(index);
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

                      children: List.generate(widget.imagesList[index].length,
                          (imgIndex) {
                        // si es mapa es porque tiene ciclos
                        final dynamic img = widget.imagesList[index][imgIndex];
                        if (img is Map) {
                          return _buildCardForMap(img);
                        } else {
                          return Image.asset(
                            'assets/buttons/$img',
                            height: 40,
                            width: img == 'Avanzar.png' ||
                                    img == 'GirarIzq.png' ||
                                    img == 'GirarDerecha.png' ||
                                    img == 'Agarrar.png' ||
                                    img == 'Derecha.png' ||
                                    img == 'Arriba.png' ||
                                    img == 'Abajo.png' ||
                                    img == 'Izquierda.png' 
                                ? 40
                                : 100,
                            fit: BoxFit.cover,
                          );
                        }
                      }),
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

  Widget _buildCardForMap(dynamic respuesta) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${respuesta['Repeticion']}x',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0, // Espacio entre las imágenes
              runSpacing: 8.0,
              children: List.generate(
                respuesta['Respuestas'].length,
                (imgIndex) => Image.asset(
                  'assets/buttons/${respuesta['Respuestas'][imgIndex]}',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
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
