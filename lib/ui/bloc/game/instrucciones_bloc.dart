import 'package:flutter_bloc/flutter_bloc.dart';

class InstruccionesCubit extends Cubit<List<MapEntry<String, String>>> {
  InstruccionesCubit() : super([]);

  // Método para agregar una instrucción a la lista actual
  void agregarIntruccion(String instruccion) {
    List<MapEntry<String, String>> instrucciones = List.from(state);
    instrucciones.add(MapEntry(instruccion, rutaInstruccion(instruccion)));
    emit(instrucciones);
  }

  void limpiarInstrucciones() {
    emit([]);
  }

  String rutaInstruccion(String instruccion) {
    switch (instruccion) {
      case 'izquierda':
        return 'assets/buttons/Izquierda.png';
      case 'derecha':
        return 'assets/buttons/Derecha.png';
      case 'arriba':
        return 'assets/buttons/Arriba.png';
      case 'abajo':
        return 'assets/buttons/Abajo.png';
      case 'avanzar':
        return 'assets/buttons/Derecha.png';
      case 'giroDeIzquierda':
        return 'assets/buttons/GirarIzq.png';
      case 'giroDeDerecha':
        return 'assets/buttons/GirarDerecha.png';
      case 'recoger':
        return 'assets/buttons/Agarrar.png';
      default:
        return '';
    }
  }
}
