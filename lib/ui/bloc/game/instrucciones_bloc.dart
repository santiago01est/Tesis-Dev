import 'package:flutter_bloc/flutter_bloc.dart';

class InstruccionesCubit extends Cubit<List<MapEntry<dynamic, String>>> {
  InstruccionesCubit() : super([]);

  // Método para agregar una instrucción a la lista actual
  void agregarIntruccion(dynamic instruccionesDynamic, String nombreArchivo) {
    List<MapEntry<dynamic, String>> instrucciones = List.from(state);
    instrucciones.add(MapEntry(instruccionesDynamic, rutaInstruccion(nombreArchivo)));

    emit(instrucciones);
  }

  // Método para limpiar la lista actual de instrucciones

  void limpiarInstrucciones() {
    emit([]);
  }

  String rutaInstruccion(String instruccion) {
    switch (instruccion) {
      case 'avanzar':
        return 'assets/buttons/Avanzar.png';
      case 'giroDeIzquierda':
        return 'assets/buttons/GirarIzq.png';
      case 'giroDeDerecha':
        return 'assets/buttons/GirarDerecha.png';
      case 'recoger':
        return 'assets/buttons/Agarrar.png';
      case 'Nivel 1':
        return 'assets/buttons/Nivel 1.png';
      case 'Nivel 2':
        return 'assets/buttons/Nivel 2.png';
      case 'Nivel 2-X':
        return 'assets/buttons/Nivel 2-X.png';
      case 'Nivel 3':
        return 'assets/buttons/Nivel 3.png';
      case 'Nivel 3-X':
        return 'assets/buttons/Nivel 3-X.png';
      case 'Nivel 4':
        return 'assets/buttons/Nivel 4.png';
      case 'Nivel 4-X':
        return 'assets/buttons/Nivel 4-X.png';
      case 'Nivel 2, 3 y 4':
        return 'assets/buttons/Nivel 2, 3 y 4.png';
      case 'Nivel 3 y 4':
        return 'assets/buttons/Nivel 3 y 4.png';
      case 'Nivel 3 y 4-X':
        return 'assets/buttons/Nivel 3 y 4-X.png';
      default:
        return '';
    }
  }
}
