//clase posicion con id, numeroPosicion, tipoPosicion y recurso
class Casilla {
  String id;
  List<int> numeroCasillas;
  String tipoCasilla;
  String recurso;
  Casilla({
    required this.id,
    required this.numeroCasillas,
    required this.tipoCasilla,
    required this.recurso,
  });
}
