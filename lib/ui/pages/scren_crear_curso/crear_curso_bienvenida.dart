import 'dart:async';

import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:excel/excel.dart';

class CrearCursoBienvenidaScreen extends StatefulWidget {
  const CrearCursoBienvenidaScreen({super.key});

  @override
  State<CrearCursoBienvenidaScreen> createState() =>
      _CrearCursoBienvenidaScreenState();
}

class _CrearCursoBienvenidaScreenState
    extends State<CrearCursoBienvenidaScreen> {
  @override
  Widget build(BuildContext context) {
    final profesorCubit = context.watch<ProfesorCubit>();
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBarProfesor(
        title: 'Mundo PC',
        userName: profesorCubit.state.nombre ?? '',
        avatarImagePath: profesorCubit.state.avatar ?? '',
        onAvatarTap: () {
          print('Avatar tap');
        },
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/FondoCrearCurso.png',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Center(
                child: Container(
              //ancho 80% del ancho de la pantalla
              width: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(50),
              child: Card(
                color: Colors.black.withOpacity(0.5), // Negro transparente
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.width < 600
                              ? 10
                              : 50),
                      const Text(
                        '¡Ahora es el momento de crear tu primer curso en Mundo PC!',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width < 600
                              ? 10
                              : 50),
                      const Text(
                        'Imagina tu curso como un viaje inspirador, donde cada lección es una puerta a la creatividad, la resolución de problemas y el descubrimiento. Tu compromiso con los estudiantes es la chispa que encenderá la llama del aprendizaje, cultivando no solo habilidades lógicas, sino también la confianza y la curiosidad.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width < 600
                              ? 10
                              : 40),
                      Container(
                          width: 300,
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: PixelLargeBttn(
                              path: 'assets/items/bttn_crearcurso.png',
                              onPressed: () {}))
                    ],
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
    // Contenido superpuesto en la primera sección
  }
}
