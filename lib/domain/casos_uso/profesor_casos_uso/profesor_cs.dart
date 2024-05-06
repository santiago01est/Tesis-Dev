import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/domain/repository/profesor_respository.dart';
import 'package:flutter/material.dart';

class ProfesorCasoUso {
  final ProfesorRepository profesorRepository;
  final BuildContext context;
  ProfesorCasoUso({required this.profesorRepository, required this.context});

  Future<List<Profesor>> getProfesores() {
    return profesorRepository.getProfesores();
  }
}
