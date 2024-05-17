import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SeguimientoEstudianteScreen extends StatefulWidget {
  final int cursoId;
  const SeguimientoEstudianteScreen({super.key, required this.cursoId});

  @override
  State<SeguimientoEstudianteScreen> createState() =>
      _SeguimientoEstudianteScreenState();
}

class _SeguimientoEstudianteScreenState
    extends State<SeguimientoEstudianteScreen> {
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();
  final UnidadCasoUso unidadCasoUso = getIt<UnidadCasoUso>();
  final ProfesorCasoUso profesorCasoUso = getIt<ProfesorCasoUso>();


  late Future<void> _cursosProfesoresCasoUso;
  bool _isLoading = true;
  bool _isInitialized = false; // Variable para controlar el estado de carga


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {

      _cursosProfesoresCasoUso = _initializeData();
      _isInitialized = true;
    }
  }

  Future<void> _initializeData() async {
    final initData = InitData(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );

        await initData.obtenerCursosYProfesoresYUnidades(widget.cursoId);

      
    
    _simularCarga();
  }

  void _simularCarga() {
    // Simular una carga de 5 segundos
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cursoCubit = context.read<CursoCubit>();
    final seguimientos = context.watch<SeguimientosEstudiantesCubit>().state;
    final estudiantesCubit = context.read<EstudiantesCubit>();
    final router = GoRouter.of(context);
    final estudiantes = estudiantesCubit.state;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Boton que al dar cli aparezca una ventana
              // con el nombre del curso
/*
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Nombre del Curso'),
                          content: Text('${seguimientos.length}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Nombre del Curso'),
                ),
              ),
*/
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
                  estudiantes: estudiantes,
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
                  estudiantes: estudiantes,
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
                  estudiantes: estudiantes,
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
                  estudiantes: estudiantes,
                  listaBase: List.generate(13, (index) => -1)),
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

    // Agregar las columnas para las actividades
    columns.addAll(widget.actividades.map((activity) {
      return DataColumn(
        label: Text('Act ${activity.id! + 1}'),
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

  Color asignarColor(int colIndex) {
    if (colIndex < 4) {
      return Color(0xFFB6C979);
    } else if (colIndex >= 4 && colIndex < 8) {
      return Color(0xFFF4A662);
    } else {
      return Color(0xFF69B5D8);
    }
  }
}

class DataTestTableWidget extends StatefulWidget {
  final List<Estudiante> estudiantes;
  final List<int> listaBase;

  const DataTestTableWidget(
      {super.key, required this.estudiantes, required this.listaBase});
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

    // Agregar las columnas para los seguimientos
    // lista de 13 items con -1

    for (int i = 0; i < widget.listaBase.length; i++) {
      columns.add(DataColumn(label: Text('${i + 1}')));
    }

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

    int i = 0;
    for (var activity in widget.listaBase) {
      Color cellColor = asignarColor(16);
      final seguimientos = context.read<SeguimientosEstudiantesCubit>();
      final seguimiento =
          seguimientos.obtenerSeguimientoEstudiante(student.id!);

      int peso = seguimiento.test![i];

      if (peso == -1) {
        peso = 0;
      } else {
        peso++;
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
      i++;
    }

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

  Color asignarColor(int colIndex) {
    if (colIndex < 4) {
      return Color(0xFFB6C979);
    } else if (colIndex >= 4 && colIndex < 8) {
      return Color(0xFFF4A662);
    } else {
      return Color(0xFF69B5D8);
    }
  }
}
