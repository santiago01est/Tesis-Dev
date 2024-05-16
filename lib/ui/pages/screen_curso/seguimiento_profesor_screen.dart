import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/grupo.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class SeguimientoProfesorScreen extends StatefulWidget {
  final int cursoId;

  const SeguimientoProfesorScreen({super.key, required this.cursoId});

  @override
  State<SeguimientoProfesorScreen> createState() =>
      _SeguimientoProfesorScreenState();
}

class _SeguimientoProfesorScreenState extends State<SeguimientoProfesorScreen> {
  late InitData _cursosProfesoresCasoUso;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cursosProfesoresCasoUso = InitData(
      cursosCasoUso: CursosCasoUso(cursoRepository: getIt<CursoRepository>()),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );
    _cursosProfesoresCasoUso
        .obtenerCursosYProfesoresYUnidades(widget.cursoId)
        .then((value) => setState(() {
          final cursoCubit = context.read<CursoCubit>();
          final profesor= context.read<ProfesoresCubit>().state.where((element) => element.id == cursoCubit.state.profesor).first;
           Estudiante yoEstudiante = Estudiante(
          id: profesor.id,
          nombre: profesor.nombre,
          avatar: profesor.avatar,
          genero: 'Otro');


          context.read<EstudiantesCubit>().subirEstudiantes([yoEstudiante]);
          
              context.read<RolCubit>().actualizarRol("profesor");
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final cursoCubit = context.watch<CursoCubit>();
    final totalEstudiantes = cursoCubit.state.estudiantes!;
    //final profesor= context.read<ProfesoresCubit>().state.where((element) => element.id == cursoCubit.state.profesor).first;
  
  
    final seguimientos = context.watch<SeguimientosEstudiantesCubit>().state;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blueDarkColor), // Cambia el color aquí
        backgroundColor: sixtyColor,
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2822823910.
        title: Text(
          'Seguimiento General',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              router.go('/panelcurso/${widget.cursoId}');
            },
            icon: Icon(Icons.home, color: blueDarkColor),
            tooltip: 'Inicio', // Aquí personalizas el texto de ayuda
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: TitleText(text: '${cursoCubit.state.nombre}'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: SubtitleText(text: 'Unidad Diagnóstica'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Wrap(
                        children: [
                          //cuadro de color azul y un texto al lado
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB6C979),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Actividades Secuencia'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4A662),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Actividades Ciclos'),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF69B5D8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Actividades Ciclos Anidados'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DataTableWidget(
                        estudiantes: totalEstudiantes,
                        actividades: cursoCubit.state.unidades![0].actividades!,
                        seguimientos: seguimientos),
                    SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: SubtitleText(text: 'Unidad 1'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DataTableWidget(
                        estudiantes: totalEstudiantes,
                        actividades: cursoCubit.state.unidades![1].actividades!,
                        seguimientos: seguimientos),
                    SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: SubtitleText(text: 'Unidad 2'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DataTableWidget(
                        estudiantes: totalEstudiantes,
                        actividades: cursoCubit.state.unidades![2].actividades!,
                        seguimientos: seguimientos),
                    SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: SubtitleText(text: 'Test Autopercepción'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DataTestTableWidget(
                        estudiantes: totalEstudiantes,
                        respuestas: seguimientos),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DataTableWidget extends StatefulWidget {
  final List<Estudiante> estudiantes;
  final List<Actividad> actividades;
  final List<Seguimiento> seguimientos;

  const DataTableWidget(
      {super.key,
      required this.estudiantes,
      required this.actividades,
      required this.seguimientos});
  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  final ScrollController _scrollController = ScrollController();
  CursosCasoUso cursoCs = getIt<CursosCasoUso>();
   Map<String, TextEditingController> createControllersMap(
      List<Grupo> grupos, List<Estudiante> estudiantes) {
    Map<String, TextEditingController> controllersMap = {};

    // Iterar sobre la lista de grupos
    if(grupos.isEmpty){

      for (var grupo in grupos) {
      // Obtener los IDs de los estudiantes en el grupo
      List<int> studentIds = [grupo.idEstudiante1!, grupo.idEstudiante2!];

      // Si el grupo tiene dos estudiantes, combinar sus IDs y crear un TextEditingController
      String combinedIds = "${studentIds[0]},${studentIds[1]}";
      controllersMap[combinedIds] =
          TextEditingController(text: "Valor inicial para $combinedIds");
    }

    }
    

    // Iterar sobre la lista de estudiantes individuales
    for (var estudiante in estudiantes) {
      // Verificar si el estudiante no está en ningún grupo
      if (!grupos.any((grupo) =>
          grupo.idEstudiante1 == estudiante.id ||
          grupo.idEstudiante2 == estudiante.id)) {
        // Si el estudiante no está en ningún grupo, crear un TextEditingController para él y agregarlo al mapa
        controllersMap[estudiante.id.toString()] =
            TextEditingController(text: "Valor inicial para ${estudiante.id}");
      }
    }

    return controllersMap;
  }

  TextEditingController? getControllerForStudentId(
      int studentId, Map<String, TextEditingController> controllersMap) {
    // Buscar el estudiante en las claves del mapa
    for (var key in controllersMap.keys) {
      // Separar los IDs de la clave por coma
      List<String> ids = key.split(',');
      // Verificar si el ID del estudiante coincide con alguno de los IDs en la clave
      if (ids.contains('$studentId')) {
        // Retornar el TextEditingController correspondiente
        return controllersMap[key];
      }
    }
    // Si no se encuentra ningún TextEditingController para el estudiante
    return null;
  }


  @override
  Widget build(BuildContext context) {
    
    //print('$controllersMap');
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Container(
          // Container para aplicar el color de fondo a toda la tabla
          decoration: BoxDecoration(
            // Decoración para el color de fondo de la tabla
            color: Color(0xFFACD8ED),
            borderRadius:
                BorderRadius.circular(8.0), // Color de fondo de la tabla
          ),
          child: DataTable(
            columns: _buildColumns(),
            rows: _buildRows(),
           columnSpacing: 12.0, // Espaciado horizontal entre columnas
  dataRowMinHeight: 48.0, // Altura de las filas
  dataRowMaxHeight: 58.0,
  headingRowHeight: 56.0, // Altura de la fila de encabezado
  // Para espaciado vertical entre filas:
  // spacing: 10.0, // Por ejemplo, espaciado de 10 píxeles entre filas
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    List<DataColumn> columns = [];

    // Agregar la primera columna para los nombres de los estudiantes
    columns.add(DataColumn(label: Text('Estudiante')));

    // Agregar las columnas para las actividades
    columns.addAll(widget.actividades.map((activity) {
      return DataColumn(
        label: Text('Act ${activity.id! }'),
      );
    }).toList());

    // Agregar columna para el promedio
    columns.add(DataColumn(label: Text('Promedio')));

    return columns;
  }

  List<DataRow> _buildRows() {
    return widget.estudiantes.map((student) {
      int rowIndex = widget.estudiantes.indexOf(student);
      return DataRow(
        cells: _buildCells(student, rowIndex),
      );
    }).toList();
  }

  List<DataCell> _buildCells(Estudiante student, int rowIndex) {
    List<DataCell> cells = [];

    // Agregar la celda con el nombre del estudiante
    cells.add(DataCell(Text(student.nombre!)));

    // Crear el mapa de controladores para este estudiante
  Map<String, TextEditingController> controllersMap = createControllersMap(
    [],
    widget.estudiantes,
  );

  List<String> promedios=List.filled(widget.estudiantes.length, '1');

    // Agregar las celdas para las actividades con números aleatorios
    List<int> activityValues =
        []; // Lista para almacenar los valores de actividades
    widget.actividades.forEach((activity) {
      Color cellColor = asignarColor(activity.id!);

      Seguimiento seguimiento = widget.seguimientos
          .firstWhere((element) => element.userId == student.id);

      Respuesta miRespuesta = seguimiento.respuestasActividades!
          .firstWhere((element) => element.actividadId == activity.id);
      int peso = miRespuesta.peso!;

      if (peso == -1) {
        peso = 0;
      }

      if (activity.tipoActividad == 'Desconectada') {
        // Obtener el controlador para este estudiante o grupo
      TextEditingController? controller =
          getControllerForStudentId(student.id!, controllersMap);
        // Llamar a esta función cuando se cambie el valor en el NumberPicker
        cells.add(DataCell(
          Container(
            margin:  const EdgeInsets.all(4.0),
            
            child: NumberInputPrefabbed.directionalButtons(
              controller: controller!,
              initialValue: peso,
              min: 1,
              max: 4,
              onChanged: (value) {
                controller.text = value.toString();
                peso = int.parse(value.toString());
                double total = activityValues.fold(0, (sum, value) => sum + value);
                double average = total / activityValues.length;
                setState(() {
                  promedios[rowIndex] = average.toStringAsFixed(1);
                  
                });
                
                
                actualizarSeguimiento(
                  value.toString(), student.id!, seguimiento.cursoId!, activity.id!
                );
              },
              incDecBgColor: orangeColor,
            ),
          ),
        ));
      } else {
        cells.add(
          DataCell(
            Container(
              margin:  const EdgeInsets.all(8.0),
              width: 48.0,
              height: 48.0,
              alignment: Alignment.center,
              child: Text(
                peso.toString(),
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: cellColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        );
      }

      // Agregar el valor numérico de la actividad a la lista
      activityValues.add(peso);
    });

    // Calcular el promedio de los valores de las actividades
    double total = activityValues.fold(0, (sum, value) => sum + value);
    double average = total / activityValues.length;
    promedios[rowIndex] = average.toStringAsFixed(1);
    

    // Agregar la celda para el promedio al final
    cells.add(
      DataCell(
        Container(
          width: 48.0,
          alignment: Alignment.center,
          child: Text(
            promedios[rowIndex],
            //average.toStringAsFixed(2), // Mostrar el promedio con dos decimales
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            color: Colors.grey, // Color para la celda del promedio
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );

    return cells;
  }

  void updateAverage() {
  setState(() {
    // Calcular el promedio de los valores de actividades actualizados
    //double total = activityValues.fold(0, (sum, value) => sum + value);
    //double average = total / activityValues.length;
    // Actualizar el promedio en la tabla
    // Puedes almacenar el promedio en una lista o un mapa y luego acceder a él en _buildCells
    // para mostrarlo en la última celda de cada fila.
  });
}

  // Función para manejar los cambios en el TextField
  void handleNumberPickerChange(
      int actividadId, int estudianteId, String text) {
    // Aquí puedes hacer lo que necesites con la información recibida
    print(
        'Actividad ID: $actividadId, Estudiante ID: $estudianteId, Texto: $text');
  }

  Color asignarColor(int colIndex) {
    if (colIndex < 4) {
      return Color(0xFFB6C979);
    } else if (colIndex >= 4 && colIndex < 8) {
      return Color(0xFFF4A662);
    } else {
      return Color(0xFF69B5D8);
    }
  }
  
  void actualizarSeguimiento(String peso, int userId, int cursoId, int actividadId) {
    context.read<SeguimientosEstudiantesCubit>().actualizarCalificacionActividadSeguimiento(userId, actividadId, int.parse(peso), cursoId);

        //guardar en la base de datos FB si es diferente del curso demo
        if (cursoId != 1){
           cursoCs.actualizarRespuesta(
           cursoId,  [userId],
       actividadId, int.parse(peso), ''
            );

        }
  }

  
}

class DataTestTableWidget extends StatefulWidget {
  final List<Estudiante> estudiantes;
  final List<Seguimiento> respuestas;

  const DataTestTableWidget(
      {super.key, required this.estudiantes, required this.respuestas});
  @override
  _DataTestTableWidgetState createState() => _DataTestTableWidgetState();
}

class _DataTestTableWidgetState extends State<DataTestTableWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Container(
          // Container para aplicar el color de fondo a toda la tabla
          decoration: BoxDecoration(
            // Decoración para el color de fondo de la tabla
            color: Color(0xFFACD8ED),
            borderRadius:
                BorderRadius.circular(8.0), // Color de fondo de la tabla
          ),
          child: DataTable(
            columns: _buildColumns(),
            rows: _buildRows(),
            columnSpacing: 12.0,
            dataRowHeight: 48.0,
            headingRowHeight: 56.0,
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    List<DataColumn> columns = [];

    // Agregar la primera columna para los nombres de los estudiantes
    columns.add(DataColumn(label: Text('Estudiante')));

    //lista de 13 elementos
    List<int> respuestasTest = [];
    for (int i = 0; i < 13; i++) {
      respuestasTest.add(i);
    }

    // Agregar las columnas para las actividades
    columns.addAll(respuestasTest.map((item) {
      return DataColumn(
        //obtener posicion del item en la lista
        label: Text('${item + 1}'),
      );
    }).toList());

    // Agregar columna para el promedio
    columns.add(DataColumn(label: Text('Promedio')));

    return columns;
  }

  List<DataRow> _buildRows() {
    return widget.estudiantes.map((student) {
      int rowIndex = widget.estudiantes.indexOf(student);
      return DataRow(
        cells: _buildCells(student, rowIndex),
      );
    }).toList();
  }

  List<DataCell> _buildCells(Estudiante student, int rowIndex) {
    List<DataCell> cells = [];

    // Agregar la celda con el nombre del estudiante
    cells.add(DataCell(Text(student.nombre!)));

    // Agregar las celdas para las actividades con números aleatorios
    List<int> activityValues =
        []; // Lista para almacenar los valores de actividades
    List<int> respuestasTest = widget.respuestas
        .firstWhere(
          (element) => element.userId == student.id,
        )
        .test!;

    respuestasTest.forEach((item) {
      Color cellColor = const Color(0xFFB6C979);

      int peso = item;

      if (peso == -1) {
        peso = 0;
      }

      cells.add(
        DataCell(
          Container(
            width: 48.0,
            alignment: Alignment.center,
            child: Text(
              peso.toString(),
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: cellColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      );

      // Agregar el valor numérico de la actividad a la lista
      activityValues.add(peso);
    });

    // Calcular el promedio de los valores de las actividades
    double total = activityValues.fold(0, (sum, value) => sum + value);
    double average = total / activityValues.length;

    // Agregar la celda para el promedio al final
    cells.add(
      DataCell(
        Container(
          width: 48.0,
          alignment: Alignment.center,
          child: Text(
            average.toStringAsFixed(2), // Mostrar el promedio con dos decimales
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            color: Colors.grey, // Color para la celda del promedio
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );

    return cells;
  }

  
}
