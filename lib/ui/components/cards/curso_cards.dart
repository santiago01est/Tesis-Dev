import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:flutter/material.dart';

class CursoCard extends StatelessWidget {
  final Curso curso;

  const CursoCard({Key? key, required this.curso}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Card(
        elevation: 5,
        // estilo de la card con bordes redondos
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //color de la card
        color: orangeColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              curso.portada ?? 'assets/FondoInicio.png',
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curso.nombre!, // Nombre del curso
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    curso.descripcion ?? '',
                    maxLines: 3, // Número máximo de líneas
                    overflow: TextOverflow.ellipsis, // Descripción del curso
                  ),
                  Text(
                    'Profesor: ${curso.profesor}', // Nombre del profesor
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
