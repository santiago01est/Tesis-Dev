import 'dart:math'; // Importa la librería math para generar números aleatorios

import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeguimientoProfesorScreen extends StatelessWidget {
  const SeguimientoProfesorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cursoCubit = context.read<CursoCubit>();
    final estudiantes = cursoCubit.state.estudiantes!;
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(color: blueDarkColor), // Cambia el color aquí
        backgroundColor: sixtyColor,
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2822823910.
        title: Text('Seguimiento General', style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {},
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
              DataTableWidget(estudiantes: estudiantes),
            ],
          ),
        ),
      ),
    );
  }
}

class DataTableWidget extends StatefulWidget {
  final List<Estudiante> estudiantes;

  const DataTableWidget({super.key, required this.estudiantes});
  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  final ScrollController _scrollController = ScrollController();

  final List<String> activities = [
    'Act 1',
    'Act 2',
    'Act 3',
    'Act 4',
    'Act 5',
    'Act 6',
    'Act 7',
    'Act 8',
    'Act 9',
    'Act 10',
    'Act 11',
    'Act 12',
    'Act 13',
    'Act 14',
    'Act 15',
  ];

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
    columns.addAll(activities.map((activity) {
      return DataColumn(
        label: Text(activity),
      );
    }).toList());

    // Agregar columna para el promedio
    columns.add(DataColumn(label: Text('Promedio')));

    return columns;
  }

  List<DataRow> _buildRows() {
    Random random = Random();
    return widget.estudiantes.map((student) {
      int rowIndex = widget.estudiantes.indexOf(student);
      return DataRow(
        cells: _buildCells(student, rowIndex, random),
      );
    }).toList();
  }

  List<DataCell> _buildCells(Estudiante student, int rowIndex, Random random) {
    List<DataCell> cells = [];

    // Agregar la celda con el nombre del estudiante
    cells.add(DataCell(Text(student.nombre!)));

    // Agregar las celdas para las actividades con números aleatorios
    List<int> activityValues =
        []; // Lista para almacenar los valores de actividades
    activities.forEach((activity) {
      int randomNumber = random.nextInt(4) + 1;
      Color cellColor = asignarColor(activities.indexOf(activity));
      final seguimientos = context.read<SeguimientosEstudiantesCubit>();
      final seguimiento =
          seguimientos.obtenerSeguimientoEstudiante(student.id!);

      int peso =
          seguimiento.respuestasActividades![activities.indexOf(activity)];

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

  int obtenerPesoActividad(int? idEstudiante, int indexActividad) {
    final seguimientos = context.read<SeguimientosEstudiantesCubit>();
    final seguimiento =
        seguimientos.obtenerSeguimientoEstudiante(idEstudiante!);
    final unidad = context.read<UnidadesCubit>();
    Actividad actividad = unidad.actividadPorId('${indexActividad + 1}')!;
    int respuestaEstudiante =
        seguimiento.respuestasActividades![indexActividad];

    // toast

    if (respuestaEstudiante == -1) {
      return 0;
    } else {
      return actividad.pesoRespuestas![respuestaEstudiante - 1];
    }
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
