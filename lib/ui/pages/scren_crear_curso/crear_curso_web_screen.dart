import 'dart:async';
import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/combobox/combobox_ubicacion.dart';
import 'package:dev_tesis/ui/widgets/PopUp.dart';
import 'package:dev_tesis/utils/manejoExcel.dart';
import 'dart:html' as html;
import 'package:dev_tesis/utils/rutasImagenes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrearCursoWebScreen extends StatefulWidget {
  const CrearCursoWebScreen({super.key});

  @override
  State<CrearCursoWebScreen> createState() => _CrearCursoWebScreenState();
}

class _CrearCursoWebScreenState extends State<CrearCursoWebScreen> {
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();
  final UnidadCasoUso unidadCasoUso = getIt<UnidadCasoUso>();

//ruta imagene portada prederteminada
  String selectedImages = RutasImagenes.getRutasPortadas()[0];

// ruta avatar predeterminado
  String selectedAvatar = RutasImagenes.getRutasAvatares()[0];

// Datos ubicacion
  String selectedDepartamento = '';
  String selectedMunicipio = '';
  List<String> departamentos = [];
  List<String> municipios = [];

  // variable para el stepper
  int _currentStep = 0;

  // seleccion plantilla
  bool _isPlantillaSeleccionada = false;

  // lista estudiantes
  List<Estudiante> listaEstudiantes = [];

  // indice identificar estudiante

  int indiceEstudiante = 0;

  // controladores de los formularios
  final TextEditingController _nombreCursoController = TextEditingController();
  final TextEditingController _descripcionCursoController =
      TextEditingController();
  final TextEditingController _colegioCursoController = TextEditingController();
  final TextEditingController _codigoAccesoController = TextEditingController();
  final TextEditingController _nombreEstudianteController =
      TextEditingController();

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
    _fetchDepartamentos();
  }

  Future<void> _fetchDepartamentos() async {
    final response = await http
        .get(Uri.parse('https://www.datos.gov.co/resource/xdk5-pm3f.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> departamentosList = [];

      for (final departamento in data) {
        departamentosList.add(departamento['departamento']);
      }

      setState(() {
        Set<String> conjuntoDeptoUnico = Set<String>.from(departamentosList);
        // Convertir el conjunto de nuevo a una lista
        departamentos = conjuntoDeptoUnico.toList();
        print(departamentos);
      });
    }
  }

  Future<void> _fetchMunicipios(String departamento) async {
    final response = await http.get(Uri.parse(
        'https://www.datos.gov.co/resource/xdk5-pm3f.json?departamento=$departamento'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> municipiosList = [];

      for (final municipio in data) {
        municipiosList.add(municipio['municipio']);
      }

      setState(() {
        Set<String> conjuntoDeptoUnico = Set<String>.from(municipiosList);
        // Convertir el conjunto de nuevo a una lista
        municipios = conjuntoDeptoUnico.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profesorCubit = context.watch<ProfesorCubit>();
    final cursoCubit = context.watch<CursoCubit>();
    final bdCursosCubit = context.read<BDCursosCubit>();
    final router = GoRouter.of(context);

    final List<StepForm> _stepForms = [
      StepForm(title: 'Información del Curso', formFields: [
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Nombre del Curso *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nombreCursoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Ingresa un Nombre para el curso",
                    prefixIcon: const Icon(Icons.book_online_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
                //Lets apply validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "nombre requerido";
                  }
                  return null;
                },
                //onChanged: (value) => _nadadorData.nombre = value,
              ),
            ])),
        const SizedBox(
          height: 20,
        ),
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Descripción *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descripcionCursoController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Ingresa una Descripción para el curso",
                    prefixIcon: const Icon(Icons.book_online_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
                //Lets apply validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "descripcion requerido";
                  }
                  return null;
                },
                //onChanged: (value) => _nadadorData.nombre = value,
              ),
            ])),
        const SizedBox(
          height: 20,
        ),
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Departamento',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              ComboboxUbicacion(
                textoHint: 'Selecciona un Departamento',
                listaUbicaciones: departamentos,
                onChanged: _selectDepto,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Municipio',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              ComboboxUbicacion(
                textoHint: 'Selecciona un Municipio',
                listaUbicaciones: municipios,
                onChanged: _selectMunicipio,
              ),
            ])),
        const SizedBox(height: 20),
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Código de Acceso *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _codigoAccesoController,
                keyboardType: TextInputType.text,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Ingresa un codigo de acceso de 4 cifras",
                    prefixIcon: const Icon(Icons.book_online_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
                //Lets apply validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "codigo requerido";
                  }
                  return null;
                },
                //onChanged: (value) => _nadadorData.nombre = value,
              ),
            ])),
        const SizedBox(
          height: 20,
        ),
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Colegio *',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _colegioCursoController,
                keyboardType: TextInputType.text,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Ingresa Nombre del Colegio",
                    prefixIcon: const Icon(Icons.book_online_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    fillColor: Colors.white),
                //Lets apply validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Colegio requerido";
                  }
                  return null;
                },
                //onChanged: (value) => _nadadorData.nombre = value,
              ),
            ])),
        const SizedBox(height: 20),
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Portada para el curso',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              // card que funciona como boton con una imagen en el centro
              InkWell(
                onTap: () {
                  PopupUtils.showPortadaSelectionPopup(
                      context, RutasImagenes.getRutasPortadas(), _selectImage);
                },
                child: Container(
                  width:
                      double.infinity, // Ajusta el ancho según tus necesidades
                  height: 200, // Ajusta la altura según tus necesidades
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle, // La forma es un círculo
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(selectedImages),
                      fit: BoxFit.cover, // Ajuste para cubrir la tarjeta
                    ),
                  ),
                ),
              ),
            ])),
      ]),
      StepForm(title: 'Plantilla', formFields: [
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selecciona una plantilla para el curso',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'recuerda que luego puedes personalizarla',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ])),
        const SizedBox(
          height: 30,
        ),
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                onTap: () {
                  /*
                  Fluttertoast.showToast(
                    msg: 'Plantilla Seleccionada',
                    toastLength:
                        Toast.LENGTH_LONG, // Duración corta del mensaje
                    gravity: ToastGravity
                        .BOTTOM, // Posición del mensaje en la pantalla
                    backgroundColor: Colors.blue, // Color de fondo del mensaje
                    textColor: Colors.white, // Color del texto del mensaje
                  );
                  */
                },
                child: Container(
                  width:
                      double.infinity, // Ajusta el ancho según tus necesidades
                  height: 200, // Ajusta la altura según tus necesidades
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle, // La forma es un círculo
                    borderRadius: BorderRadius.circular(10),
                    //color del borde
                    border: Border.all(color: Colors.blue, width: 2),
                    image: DecorationImage(
                      image: AssetImage(selectedImages),
                      fit: BoxFit.cover, // Ajuste para cubrir la tarjeta
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                title: const Text(
                    "Plantilla básica\n* 3 Unidades\n* 10 Actividades por Unidad"),
                value: _isPlantillaSeleccionada,
                onChanged: (bool? value) {
                  setState(() {
                    _isPlantillaSeleccionada = value ?? false;
                  });
                },
              ),
            ])),
        const SizedBox(
          height: 10,
        ),
      ]),
      StepForm(title: 'Incripción Estudiantes', formFields: [
        Container(
            width: 700,
            padding: const EdgeInsets.only(left: 50, right: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Inscribe estudiantes a tu curso',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              const Text(
                'cada estudiante tendrá un avatar asignado para ingresar a tu curso',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  cargarArchivoExcel();
                },
                child: const Row(children: [
                  Text(
                    'Si tienes un excel con tus estudiantes lo puedes subir aqui 👉',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.file_upload_outlined,
                      size: 40, color: Colors.green),
                ]),
              ),
              const SizedBox(height: 30),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          padding:
                              const EdgeInsets.only(top: 0, left: 0, right: 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nombre Completo del Estudiante',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _nombreEstudianteController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Ingresa nombre del estudiante",
                                      prefixIcon: const Icon(
                                          Icons.perm_identity_outlined),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none)),
                                      filled: true,
                                      isDense: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 20),
                                      fillColor: Colors.white),
                                ),
                              ])),
                    ),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Selecciona un avatar',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Center(
                                    child: Container(
                                      width: 60,
                                      child: InkWell(
                                          onTap: () {
                                            PopupUtils.showAvatarSelectionPopup(
                                                context,
                                                RutasImagenes
                                                    .getRutasAvatares(),
                                                _selectAvatar);
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    selectedAvatar), // Reemplaza 'tu_imagen.png' con la ruta correcta
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ])))
                  ]),

              const SizedBox(
                height: 10,
              ),
              //boton
              Container(
                  width: 200,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: PixelLargeBttn(
                      path: "assets/items/bttn_registrar.png",
                      onPressed: () async {
                        Estudiante estudiante = Estudiante(
                          nombre: _nombreEstudianteController.text,
                          avatar: selectedAvatar,
                        );
                        //agregar a la lista
                        agregarEstudiante(estudiante);
                        _nombreEstudianteController.clear();
                      })),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lista de Estudiantes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: listaEstudiantes.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: InkWell(
                                          onTap: () {
                                            indiceEstudiante = index;
                                            PopupUtils.showAvatarSelectionPopup(
                                                context,
                                                RutasImagenes
                                                    .getRutasAvatares(),
                                                _actualizarAvatarEstudiante);
                                          },
                                          child: CircleAvatar(
                                            radius: 20,
                                            //clic al avatar

                                            backgroundImage: AssetImage(
                                                listaEstudiantes[index].avatar),
                                          ),
                                        ),
                                        title: Text(
                                            listaEstudiantes[index].nombre),
                                        // icono de eliminar
                                        trailing: IconButton(
                                            icon: Icon(Icons.delete,
                                                color: orangeColor),
                                            onPressed: () {
                                              eliminarEstudiante(index);
                                            }));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])),
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
            padding: const EdgeInsets.only(left: 60, right: 60, top: 50),
            child: Stepper(
              type: StepperType.horizontal,
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
                              child: Container(
                            width: 150,
                            height: 80,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: PixelLargeBttn(
                              path: 'assets/items/bttn_volver.png',
                              onPressed: _onStepCancel,
                            ),
                          )),
                        const SizedBox(
                          width: 10,
                        ),
                        if (isLastStep)
                          Expanded(
                              child: Container(
                            width: 150,
                            height: 80,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: PixelLargeBttn(
                              path: 'assets/items/bttn_confirmar.png',
                              onPressed: () {
                                //TODO: Validar la información

                                List<Unidad> listaUnidades =
                                    unidadCasoUso.getUnidadesPrueba();

                                Curso curso = Curso(
                                    id: _nombreCursoController.text +
                                        profesorCubit.state.nombre!,
                                    nombre: _nombreCursoController.text,
                                    codigoAcceso: _codigoAccesoController.text,
                                    departamento: selectedDepartamento,
                                    ciudad: selectedMunicipio,
                                    colegio: _colegioCursoController.text,
                                    profesor: profesorCubit.state.nombre!,
                                    portada: selectedImages,
                                    numEstudiantes: listaEstudiantes.length,
                                    descripcion:
                                        _descripcionCursoController.text,
                                    fechaCreacion: DateTime.now().toString(),
                                    fechaFinalizacion: "",
                                    estado: true,
                                    estudiantes: listaEstudiantes,
                                    unidades: listaUnidades);
                                //TODO: Llamar a la API para guardar la información
                                cursosCasoUso.guardarCurso(curso);
                                // Guardar en Cubit
                                cursoCubit.actualizarCurso(curso);
                                bdCursosCubit.agregarCurso(curso);

                                router.go('/panelprofesorcurso/${curso.id}');
                                //bool isValid =
                                //_validateInformation(); // Verifica la información
/*
                                if (isValid) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirmación'),
                                        content: Text(
                                            '¿Estás seguro de realizar esta Inscripción?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Aquí puedes realizar la acción que desees cuando se confirme
                                              // Por ejemplo, enviar un formulario, llamar a una función, etc.
                                              Navigator.of(context).pop();
                                              showCustomSnackBar(context);
                                              _onStepContinue();
                                            },
                                            child: Text('Confirmar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Campos obligatorios'),
                                        content: Text(
                                            'Por favor, llena los campos obligatorios.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Aceptar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                */
                              },
                            ),
                          )),
                        if (_currentStep < 3 - 1)
                          Expanded(
                              child: Container(
                                  width: 150,
                                  height: 80,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: PixelLargeBttn(
                                    path: 'assets/items/bttn_continuar.png',
                                    onPressed: _onStepContinue,
                                  )))
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

  Future<Future<List<String>>> cargarArchivoExcel() async {
    final completer = Completer<List<String>>();

    html.InputElement input = html.InputElement(type: 'file')
      ..accept = '.xls,.xlsx';
    input.click();

    input.onChange.listen((e) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();

        reader.onLoadEnd.listen((e) async {
          final Uint8List fileBytes =
              Uint8List.fromList(reader.result as List<int>);
          List<String> datos = await ManejoExcel.leerArchivoExcel(fileBytes);

          for (var i = 0; i < datos.length; i++) {
            //obtener un dato de una posicion

            Estudiante estudiante = Estudiante(
                nombre: datos[i], avatar: RutasImagenes.getRandomRuta());
            agregarEstudiante(estudiante);
          }
        });

        reader.readAsArrayBuffer(file);
      }
    });

    return completer.future;
  }

  void _selectImage(String portadaPath) {
    setState(() {
      selectedImages = portadaPath;
    });
  }

  void _selectDepto(String depto) {
    setState(() {
      selectedDepartamento = depto;
      selectedMunicipio =
          ''; // Reiniciar los municipios cuando se cambia el departamento
      municipios = [];
      _fetchMunicipios(depto);
    });
  }

  void _selectMunicipio(String municipio) {
    setState(() {
      selectedMunicipio = municipio;
    });
  }

  void _selectAvatar(String avatarPath) {
    setState(() {
      selectedAvatar = avatarPath;
    });
  }

  void _actualizarAvatarEstudiante(String avatarPath) {
    setState(() {
      listaEstudiantes[indiceEstudiante].avatar = avatarPath;
    });
  }

  void agregarEstudiante(Estudiante nuevoEstudiante) {
    setState(() {
      listaEstudiantes.add(nuevoEstudiante);
    });
  }

  void eliminarEstudiante(int index) {
    setState(() {
      listaEstudiantes.removeAt(index);
    });
  }
}

class StepForm {
  final String title;
  final List<Widget> formFields;

  StepForm({required this.title, required this.formFields});
}
