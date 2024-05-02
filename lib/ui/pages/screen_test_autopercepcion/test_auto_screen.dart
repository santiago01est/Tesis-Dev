import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
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

  //lista de para guardar las respuestas de 13 posiciones
  List<int> _selectedOptions = List.filled(13, -1);

  @override
  Widget build(BuildContext context) {
    //final cursoCubit = context.watch<CursoCubit>();
    final router = GoRouter.of(context);

    final List<StepForm> _stepForms = [
      StepForm(title: '1', formFields: [
        Container(
          width: 900,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1. Conozco las habilidades básicas del Pensamiento Computacional (Abstración, Patrones, Descomposición, Algoritmos)',
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
                                groupValue: _selectedOptions[0],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[0] = value!;
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
                                groupValue: _selectedOptions[0],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[0] = value!;
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
              const SizedBox(height: 60),
              const Text(
                '2. Comprendo el funcionamiento de los bloques para construir los algoritmos (avanzar, girar a la derecha, girar a la izquierda, ciclos, recoger)',
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
                                groupValue: _selectedOptions[1],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[1] = value!;
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
                                groupValue: _selectedOptions[1],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[1] = value!;
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

              const SizedBox(height: 60),
              const Text(
                '3. Intento de forma persistente resolver problemas de Pensamiento Computacional hasta lograr la solución.',
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
                                groupValue: _selectedOptions[2],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[2] = value!;
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
                                groupValue: _selectedOptions[2],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[2] = value!;
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

              const SizedBox(height: 60),
              const Text(
                '4. Siento motivación por aprender Pensamiento Computacional.',
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
                                groupValue: _selectedOptions[3],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[3] = value!;
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
                                groupValue: _selectedOptions[3],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[3] = value!;
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

              const SizedBox(height: 60),
              const Text(
                '5. Me gusta resolver problemas de Pensamiento Computacional de manera individual.',
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
                                groupValue: _selectedOptions[4],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[4] = value!;
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
                                groupValue: _selectedOptions[4],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[4] = value!;
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
      StepForm(title: '2', formFields: [
        Container(
          width: 900,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '6. Me gusta resolver problemas de Pensamiento Computacional colaborando con mis compañeros.',
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
                                groupValue: _selectedOptions[5],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[5] = value!;
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
                                groupValue: _selectedOptions[5],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[5] = value!;
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
              const SizedBox(height: 60),
              const Text(
                '7. Analizo las instrucciones de cada actividad para posteriormente resolver el problema de Pensamiento Computacional.',
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
                                groupValue: _selectedOptions[6],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[6] = value!;
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
                                groupValue: _selectedOptions[6],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[6] = value!;
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

              const SizedBox(height: 60),
              const Text(
                '8. El Pensamiento Computacional me ha ayudado a desarrollar el pensamiento algorítmico.',
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
                                groupValue: _selectedOptions[7],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[7] = value!;
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
                                groupValue: _selectedOptions[7],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[7] = value!;
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
              const SizedBox(height: 60),
              const Text(
                '9. El Pensamiento Computacional me ha ayudado a desarrollar la creatividad.',
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
                                groupValue: _selectedOptions[8],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[8] = value!;
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
                                groupValue: _selectedOptions[8],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[8] = value!;
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
              const SizedBox(height: 60),
              const Text(
                '10. El Pensamiento Computacional me ha ayudado a desarrollar la capacidad para resolver problemas.',
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
                                groupValue: _selectedOptions[9],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[9] = value!;
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
                                groupValue: _selectedOptions[9],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[9] = value!;
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
      StepForm(title: '3', formFields: [
        Container(
          width: 900,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '11. El Pensamiento Computacional me ha ayudado a desarrollar la capacidad de trabajar en equipo.',
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
                                groupValue: _selectedOptions[10],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[10] = value!;
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
                                groupValue: _selectedOptions[10],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[10] = value!;
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
              const SizedBox(height: 60),
              const Text(
                '12. El Pensamiento Computacional me ha ayudado a desarrollar la capacidad de ser persistente.',
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
                                groupValue: _selectedOptions[11],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[11] = value!;
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
                                groupValue: _selectedOptions[11],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[11] = value!;
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

              const SizedBox(height: 60),
              const Text(
                '13. El Pensamiento Computacional me ha ayudado a desarrollar la capacidad de atención.',
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
                                groupValue: _selectedOptions[12],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[12] = value!;
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
                                groupValue: _selectedOptions[12],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOptions[12] = value!;
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
    ];

    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBarProfesor(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                                context
                                    .read<SeguimientosEstudiantesCubit>()
                                    .actualizarRespuestasTestEstudiantes(
                                        context
                                            .read<EstudiantesCubit>()
                                            .obtenerIds(),
                                        _selectedOptions);
                              },
                              text: 'Enviar',
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
