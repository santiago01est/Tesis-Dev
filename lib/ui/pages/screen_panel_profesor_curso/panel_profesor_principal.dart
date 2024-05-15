import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor_panel.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/layout_mis_cursos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanelPrincipalProfesorScreen extends StatefulWidget {
  final int profesorId;
  const PanelPrincipalProfesorScreen({super.key, required this.profesorId});

  @override
  State<PanelPrincipalProfesorScreen> createState() =>
      _PanelPrincipalProfesorScreenState();
}

class _PanelPrincipalProfesorScreenState
    extends State<PanelPrincipalProfesorScreen> {
  late InitData _cursosProfesoresCasoUso;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _cursosProfesoresCasoUso = InitData(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );
    _cursosProfesoresCasoUso
        .obtenerProfesor(widget.profesorId)
        .then((value) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final profesorCubit = context.watch<ProfesorCubit>();

    return Scaffold(
      appBar: AppBarProfesorPanel(
        profesorId: widget.profesorId,
      ),
      backgroundColor: blueColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/fondos/FondoInicio.png'), // Ruta de tu imagen de fondo
                        fit: BoxFit.cover, // Ajuste para cubrir el contenedor
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          // verifica el ancho de la pantalla
                          height: MediaQuery.of(context).size.width < 700
                              ? 50
                              : 300,
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          // Verifica el ancho de la pantalla
                          return MediaQuery.of(context).size.width > 768
                              ?
                              // Pantalla grande: utiliza una fila
                              FractionallySizedBox(
                                  widthFactor: 0.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      cardImgPerfil(
                                          profesorCubit.state.avatar!),
                                      cardInfoProfesor(
                                          profesorCubit.state
                                              .nombre!, //profesorCubit.state.nombre!,
                                          profesorCubit.state.bio!),
                                    ],
                                  ))
                              :

                              // retorna para Pantalla pequeña: utiliza una columna
                              Column(
                                  children: [
                                    cardImgPerfil(profesorCubit.state.avatar!),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: blueColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              SubtitleText(
                                                text:
                                                    profesorCubit.state.nombre!,
                                              ),
                                              const SizedBox(height: 10),
                                              ParagraphText(
                                                text: profesorCubit.state.bio!,
                                              ),
                                              // Agrega cualquier contenido adicional que desees aquí
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        }),
                      ],
                    ),
                  ),
                  // Segunda sección con fondo azul

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                          padding: const EdgeInsets.all(0),
                          child: LayoutMisCursos(
                            profesorId: widget.profesorId,
                          )),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget cardImgPerfil(String pathImg) {
    // retorna una card azul con los bordes superiores redondos
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: blueColor,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              //imagen
              Image.asset(
                pathImg,
                width: 150,
                height: 150,
              )
            ])));
  }

  Widget cardInfoProfesor(String nombre, String bio) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: blueColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SubtitleText(
                  text: nombre,
                ),
                const SizedBox(height: 10),
                ParagraphText(
                  text: bio,
                ),
                // Agrega cualquier contenido adicional que desees aquí
              ],
            ),
          ),
        ),
      ),
    );
  }
}
