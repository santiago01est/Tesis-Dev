import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CursoCard extends StatelessWidget {
  final Curso curso;
  final String nombreProfesor;

  const CursoCard({Key? key, required this.curso, required this.nombreProfesor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: orangeColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    curso.portada ?? 'assets/fondos/FondoInicio.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    curso.nombre!, // Nombre del curso
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    curso.descripcion ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    // Descripción del curso
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Profesor: $nombreProfesor',
                    maxLines: 2, // Nombre del profesor
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
