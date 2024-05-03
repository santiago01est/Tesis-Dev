int generalProfile(Map<String, bool> respuesta) {
  bool llegoAMeta = respuesta["Llego a la meta"] ?? false;
  bool mejorCamino = respuesta["Mejor camino"] ?? false;
  bool noChoco = respuesta["No choco con obstaculos"] ?? false;
  bool recogioObjeto = respuesta["Recogio el objeto/item"] ?? false;

  if (llegoAMeta && mejorCamino && noChoco && recogioObjeto) {
    return 4;
  } else if (llegoAMeta && !mejorCamino && noChoco && recogioObjeto) {
    return 3;
  } else if (llegoAMeta && mejorCamino && noChoco && !recogioObjeto) {
    return 3;
  } else if (!llegoAMeta && !mejorCamino && noChoco && !recogioObjeto) {
    return 2;
  } else if (llegoAMeta && !mejorCamino && !noChoco && recogioObjeto) {
    return 2;
  } else if (!llegoAMeta && !mejorCamino && noChoco && recogioObjeto) {
    return 2;
  } else if (!llegoAMeta && !mejorCamino && noChoco && !recogioObjeto) {
    return 1;
  } else if (!llegoAMeta && !mejorCamino && !noChoco && recogioObjeto) {
    return 1;
  } else if (!llegoAMeta && !mejorCamino && !noChoco && !recogioObjeto) {
    return 1;
  } else {
    return 1; // No ha realizado el ejercicio
  }
}
