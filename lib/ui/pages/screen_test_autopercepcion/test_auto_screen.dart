import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/utils/rutasImagenes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TestAutoPercepcionScreen extends StatefulWidget {
  const TestAutoPercepcionScreen({super.key, required String cursoId});

  @override
  State<TestAutoPercepcionScreen> createState() =>
      _TestAutoPercepcionScreenState();
}

class _TestAutoPercepcionScreenState extends State<TestAutoPercepcionScreen> {
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();
  final UnidadCasoUso unidadCasoUso = getIt<UnidadCasoUso>();

//ruta imagene portada prederteminada
  String selectedImages = RutasImagenes.getRutasPortadas()[0];

// ruta avatar predeterminado
  String selectedAvatar = RutasImagenes.getRutasAvatares()[0];

  // variable para el stepper
  int _currentStep = 0;

  // seleccion plantilla
  bool _isPlantillaSeleccionada = false;

  // lista estudiantes
  List<Estudiante> listaEstudiantes = [];

  // indice identificar estudiante

  int indiceEstudiante = 0;

  // controladores de los formularios

  bool get isLastStep => _currentStep == 3 - 1;
  bool get isFirstStep => _currentStep == 0;

  void _onStepContinue() {
    if (isLastStep) {
      _resetStepper();
    } else {
      // Si no es el último step, avanzar al siguiente step
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _onStepCancel() {
    if (!isFirstStep) {
      // Si no es el primer step, retroceder al step anterior
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _resetStepper() {
    // Resetea el stepper cuando se ha completado el último step
    setState(() {
      _currentStep = 0;
      //TODO: Limpia los controles y variables
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int? _selectedOption; // Variable para almacenar la opción seleccionada

  @override
  Widget build(BuildContext context) {
    //final cursoCubit = context.watch<CursoCubit>();
    final router = GoRouter.of(context);

    final List<StepForm> _stepForms = [
      StepForm(title: 'Test Autopercepción', formFields: [
        Container(
          width: 800,
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Conozco las habilidades básicas del Pensamiento Computacional (Abstración, Patrones, Descomposición, Algoritmos)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              // Aquí los radio buttons con imágenes
              MediaQuery.of(context).size.width > 768
                  ? Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Row(
                            children: [
                              Radio<int>(
                                value: i,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                  });
                                },
                              ),
                              Image.asset(
                                "assets/testauto/respuesta${i + 1}.png", // Ruta de la imagen
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(width: 30),
                            ],
                          ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Row(
                            children: [
                              Radio<int>(
                                value: i,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                  });
                                },
                              ),
                              Image.asset(
                                "assets/testauto/respuesta${i + 1}.png", // Ruta de la imagen
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                      ],
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
      StepForm(title: 'Plantilla', formFields: [
        Container(
          width: 700,
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pregunta 1',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              // Aquí los radio buttons con imágenes
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Row(
                      children: [
                        Radio<int>(
                          value: i,
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                        Image.asset(
                          'assets/buttons/Abajo.png', // Ruta de la imagen
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ]),
      StepForm(title: 'Incripción Estudiantes', formFields: [
        const SizedBox(
          height: 10,
        ),
      ]),
    ];

    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBarProfesor(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 60, right: 60, top: 30),
            child: Stepper(
              type: MediaQuery.of(context).size.width > 768
                  ? StepperType.horizontal
                  : StepperType.vertical,
              currentStep: _currentStep,
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: _onStepContinue,
              onStepCancel: _onStepCancel,
              steps: _stepForms.map((stepForm) {
                return Step(
                  title: Text(stepForm.title),
                  content: Card(
                    color: thirtyColor,
                    elevation: 4.0,
                    margin: EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: stepForm.formFields,
                      ),
                    ),
                  ),
                  isActive: _stepForms.indexOf(stepForm) == _currentStep,
                );
              }).toList(),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLastStep = _currentStep == 3 - 1;
                return Column(
                  children: [
                    Row(
                      children: [
                        if (_currentStep > 0)
                          Expanded(
                            child: PixelLargeBttn(
                              path: 'assets/items/ButtonOrange.png',
                              onPressed: _onStepCancel,
                              text: 'Volver',
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (isLastStep)
                          Expanded(
                            child: PixelLargeBttn(
                              path: 'assets/items/ButtonBlue.png',
                              onPressed: () {
                                //TODO: Validar la información

                                List<Unidad> listaUnidades =
                                    unidadCasoUso.getUnidadesPrueba();
                              },
                              text: 'Confirmar',
                            ),
                          ),
                        if (_currentStep < 3 - 1)
                          Expanded(
                              child: PixelLargeBttn(
                            path: 'assets/items/ButtonBlue.png',
                            onPressed: _onStepContinue,
                            text: 'Continuar',
                          ))
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StepForm {
  final String title;
  final List<Widget> formFields;

  StepForm({required this.title, required this.formFields});
}
