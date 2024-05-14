import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/utils/rutasImagenes.dart';
import 'package:flutter/material.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PopupCredenciales extends StatefulWidget {
  final List<Estudiante> estudiantes;
  final int idCurso;

  const PopupCredenciales(
      {super.key, required this.estudiantes, required this.idCurso});

  @override
  _PopupCredencialesState createState() => _PopupCredencialesState();
}

class _PopupCredencialesState extends State<PopupCredenciales>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String titleBar = 'Selecciona tu nombre y avatar correspondiente';

  int selectedStudentIndividualIndex =
      -1; // Índice del estudiante seleccionado, -1 si ninguno está seleccionado

  int selectedAvatarIndex = -1;
  List isSelectListStudents = [];
  int selectedStudentCount = 0;
  List isSelectListAvatar = [];
  int selectedAvatarCount = 0;
  int indexnumUnSelect = 0;
  int indexnumUnSelectAvatar = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2); // 2 pestañas
  }

  @override
  Widget build(BuildContext context) {
    final estudiantesCubit = context.read<EstudiantesCubit>();
    final router = GoRouter.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                titleBar,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            // TabBar para "Solo Yo" y "En Equipo"
            TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Solo Yo'),
                  Tab(text: 'En Equipo'),
                ],
                labelColor:
                    blueDarkColor, // Color del texto de la pestaña activa
                unselectedLabelColor:
                    Colors.grey, // Color del texto de la pestaña inactiva
                labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight
                        .bold), // Estilo del texto de la pestaña activa
                unselectedLabelStyle: const TextStyle(
                    fontSize: 14), // Estilo del texto de la pestaña inactiva
                indicator: BoxDecoration(
                  // Estilo de la barra debajo del texto
                  border: Border(
                    bottom: BorderSide(
                        color: blueColor,
                        width: 2), // Color y grosor de la barra
                  ),
                ),
                indicatorColor: Colors.blue,
                onTap: (index) {
                  setState(() {
                    if (index == 0) {
                      titleBar =
                          'Selecciona tu nombre y avatar correspondiente';
                    } else if (index == 1) {
                      titleBar =
                          'Selecciona los nombres y avatares correspondientes';
                    }
                  });
                }),
            // TabBarView para contenido de los tabs
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Contenido del tab "Solo Yo"
                  _buildTabContentIndividual(widget.estudiantes),
                  // Contenido del tab "En Equipo"
                  _buildTabContentGroup(widget.estudiantes),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Fila con el botón de siguiente
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 300,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: PixelLargeBttn(
                    path: "assets/items/ButtonBlue.png",
                    onPressed: () {
                      if (_tabController.index == 0) {
                        // Validar individual
                        if (selectedStudentIndividualIndex != -1 &&
                            selectedAvatarIndex != -1) {
                          String selectedStudentName = widget
                              .estudiantes[selectedStudentIndividualIndex]
                              .nombre!;
                          
                          String selectedAvatarPath = RutasImagenes
                              .getRutasAvatares()[selectedAvatarIndex];
                          bool isValid = widget.estudiantes.any((estudiante) =>
                              estudiante.nombre == selectedStudentName &&
                              estudiante.avatar == selectedAvatarPath);
                          if (isValid) {
                           

                            // Toast
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Bienvenido $selectedStudentName !'),
                            ));
                            //print('${widget.estudiantes.firstWhere((estudiante) => estudiante.nombre == selectedStudentName)}');
                             context.read<EstudiantesCubit>().subirEstudiantes([widget.estudiantes.firstWhere((estudiante) => estudiante.nombre == selectedStudentName)]);
                            
                              router.go('/panelcurso/${widget.idCurso}');
                            
                            // Navegar a la siguiente pantalla
                          } else {
                            // Mostrar mensaje de error
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'La combinación de nombre y avatar no es válida.'),
                            ));
                          }
                        } else {
                          // Mostrar mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Debes seleccionar un nombre y un avatar.'),
                          ));
                        }
                      }
                      if (_tabController.index == 1) {
                        // Verificar que se hayan seleccionado exactamente dos estudiantes y dos avatares
                        if (isSelectListStudents.length == 2 &&
                            isSelectListAvatar.length == 2) {
                          // Obtener los nombres y avatares seleccionados
                          String student1Name = isSelectListStudents[0].nombre;
                          String student2Name = isSelectListStudents[1].nombre;
                          String avatar1Path = isSelectListAvatar[0];
                          String avatar2Path = isSelectListAvatar[1];

                          // Validar si los pares de estudiantes y avatares corresponden a la información recibida
                          bool isValid = widget.estudiantes.any((estudiante) =>
                                  estudiante.nombre == student1Name &&
                                  estudiante.avatar == avatar1Path) &&
                              widget.estudiantes.any((estudiante) =>
                                  estudiante.nombre == student2Name &&
                                  estudiante.avatar == avatar2Path);

                          if (isValid) {
                             // Toast
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Bienvenidos $student1Name Y $student2Name !'),
                            ));
                            context.read<EstudiantesCubit>().subirEstudiantes([widget.estudiantes.firstWhere((estudiante) => estudiante.nombre == student1Name),widget.estudiantes.firstWhere((estudiante) => estudiante.nombre == student2Name)]);
                            /*
                            estudiantesCubit.agregarEstudiante(
                                buscarEstudiantePorNombre(student1Name));
                            estudiantesCubit.agregarEstudiante(
                                buscarEstudiantePorNombre(student2Name));
                                */
                            // Si la validación es exitosa, redirigir al usuario a la siguiente pantalla
                            router.go('/panelcurso/${widget.idCurso}');
                          } else {
                            // Si la validación falla, mostrar un mensaje de error
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'La combinación de nombre y avatar no es válida.'),
                            ));
                          }
                        } else {
                          // Si no se han seleccionado los pares requeridos, mostrar un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Debes seleccionar dos estudiantes y dos avatares.'),
                          ));
                        }
                      }
                    },
                    text: 'Ingresar',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContentIndividual(List<Estudiante> estudiantes) {
    List<String> avatarPaths = RutasImagenes.getRutasAvatares();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna de nombres
        Expanded(
          child: ListView.builder(
            itemCount: estudiantes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Actualiza el estado al hacer clic en una tarjeta
                    setState(() {
                      selectedStudentIndividualIndex = index;
                    });
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: selectedStudentIndividualIndex == index
                            ? Colors.blue
                            : Colors
                                .transparent, // Borde azul si está seleccionado
                      ),
                    ),
                    color: selectedStudentIndividualIndex == index
                        ? Colors.blue
                        : Colors.white, // Relleno azul si está seleccionado
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        estudiantes[index].nombre!,
                        style: TextStyle(
                          color: selectedStudentIndividualIndex == index
                              ? Colors.white
                              : Colors
                                  .black, // Texto blanco si está seleccionado
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 16),
        // Columna de avatares en tres columnas
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 90,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: avatarPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Actualiza el estado al hacer clic en un avatar
                  setState(() {
                    selectedAvatarIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedAvatarIndex == index
                          ? Colors.blue
                          : Colors.transparent,
                      width: selectedAvatarIndex == index
                          ? 4.0
                          : 0.0, // Ancho del borde
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(avatarPaths[index]),
                    backgroundColor: selectedAvatarIndex == index
                        ? Colors.blue
                        : Colors.transparent, // Fondo azul si está seleccionado
                    foregroundColor: selectedAvatarIndex == index
                        ? Colors.white
                        : Colors
                            .black, // Borde y contenido blanco si está seleccionado
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabContentGroup(List<Estudiante> estudiantes) {
    List<String> avatarPaths = RutasImagenes.getRutasAvatares();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna de nombres
        Expanded(
          child: ListView.builder(
            itemCount: estudiantes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (selectedStudentCount < 2) {
                      setState(() {
                        isSelectListStudents.add(estudiantes[index]);
                        //isSelect = isSelect ? true : false;
                        selectedStudentCount++;
                      });
                    } else {
                      // Aquí puedes mostrar un mensaje indicando que ya se seleccionaron 2 estudiantes
                      setState(() {
                        isSelectListStudents.removeAt(indexnumUnSelect);
                        indexnumUnSelect == 0
                            ? indexnumUnSelect = 1
                            : indexnumUnSelect = 0;
                        if (isSelectListStudents.length < 2) {
                          isSelectListStudents.add(estudiantes[index]);
                          print(isSelectListStudents);
                        }
                      });
                    }
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: isSelectListStudents.contains(estudiantes[index])
                        ? (isSelectListStudents.indexOf(estudiantes[index]) == 0
                            ? Colors.blue
                            : greenDarkColor)
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        estudiantes[index].nombre!,
                        style: TextStyle(
                          color: isSelectListStudents.contains(index)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 16),
        // Columna de avatares en tres columnas
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 90,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: avatarPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (selectedAvatarCount < 2) {
                    setState(() {
                      isSelectListAvatar.add(avatarPaths[index]);
                      selectedAvatarCount++;
                    });
                  } else {
                    // Aquí puedes mostrar un mensaje indicando que ya se seleccionaron 2 avatares
                    setState(() {
                      isSelectListAvatar.removeAt(indexnumUnSelectAvatar);
                      indexnumUnSelectAvatar == 0
                          ? indexnumUnSelectAvatar = 1
                          : indexnumUnSelectAvatar = 0;
                      if (isSelectListAvatar.length < 2) {
                        isSelectListAvatar.add(avatarPaths[index]);
                        print(isSelectListAvatar);
                      }
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelectListAvatar.contains(avatarPaths[index])
                          ? (isSelectListAvatar.indexOf(avatarPaths[index]) == 0
                              ? Colors.blue
                              : greenDarkColor)
                          : Colors.white,
                      width: isSelectListAvatar.contains(avatarPaths[index])
                          ? 5.0
                          : 0.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(avatarPaths[index]),
                    backgroundColor: isSelectListAvatar
                            .contains(avatarPaths[index])
                        ? (isSelectListAvatar.indexOf(avatarPaths[index]) == 0
                            ? Colors.blue
                            : greenDarkColor)
                        : Colors.white,
                    foregroundColor: selectedAvatarIndex == index
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Estudiante buscarEstudiantePorNombre(String selectedStudentName) {
    return widget.estudiantes
        .firstWhere((estudiante) => estudiante.nombre == selectedStudentName);
  }
}
