import 'package:dev_tesis/constants/styles.dart';
import 'package:flutter/material.dart';

class ComboboxUbicacion extends StatelessWidget {
  final String textoHint;
  final List<String> listaUbicaciones;
  //funcion para obtener el valor seleccionado
  final Function(String) onChanged;
  const ComboboxUbicacion(
      {super.key,
      required this.textoHint,
      required this.listaUbicaciones,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          filled: true, // Habilita el fondo lleno
          fillColor: Colors.white,
          labelText: textoHint,
          //borde redondo
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
      value: null, // Valor inicial
      items: listaUbicaciones.map((String municipio) {
        return DropdownMenuItem<String>(
          value: municipio,
          child: Text(municipio),
        );
      }).toList(),
      onChanged: (String? value) {
        onChanged(value!);
      },
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: blackColor), // Color del texto seleccionado
      dropdownColor: blueColor, // Color del menú desplegable
      icon: const Icon(Icons.arrow_downward, color: Colors.blue),
    );
  }
}
