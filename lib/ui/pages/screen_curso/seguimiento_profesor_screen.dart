import 'dart:math'; // Importa la librería math para generar números aleatorios

import 'package:flutter/material.dart';
class SeguimientoProfesorScreen extends StatelessWidget {
  const SeguimientoProfesorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tabla de Estudiantes y Actividades'),
        ),
           body: DataTableWidget(),
      ),
    );
  }
}
class DataTableWidget extends StatefulWidget {
  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  final ScrollController _scrollController = ScrollController();

  final List<String> students = [
    'Estudiante 1',
    'Estudiante 2',
    'Estudiante 3',
    'Estudiante 4',
    'Estudiante 5',
  ];

  final List<String> activities = [
    'Actividad A',
    'Actividad B',
    'Actividad C',
    'Actividad D',
    'Actividad E',
    'Actividad F',
    'Actividad G',
    'Actividad H',
    'Actividad I',
    'Actividad J',
    'Actividad K',
    'Actividad L',
    'Actividad M',
    'Actividad N',
    'Actividad O',
    'Actividad P',
    'Actividad Q',
    'Actividad R',
    'Actividad S',
    'Actividad T',
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: DataTable(
          columns: _buildColumns(),
          rows: _buildRows(),
          columnSpacing: 16.0,
          dataRowHeight: 48.0,
          headingRowHeight: 56.0,
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

    return columns;
  }

  List<DataRow> _buildRows() {
    Random random = Random();
    return students.map((student) {
      int rowIndex = students.indexOf(student);
      return DataRow(
        cells: _buildCells(student, rowIndex, random),
      );
    }).toList();
  }

  List<DataCell> _buildCells(String student, int rowIndex, Random random) {
    List<DataCell> cells = [];

    // Agregar la celda con el nombre del estudiante
    cells.add(DataCell(Text(student)));

    // Agregar las celdas para las actividades con números aleatorios
    cells.addAll(activities.map((activity) {
      int colIndex = activities.indexOf(activity);
      int randomNumber = random.nextInt(5) + 1;
      Color cellColor = (colIndex % 2 == 0) ? Colors.blue : Colors.green;

      return DataCell(
        Container(
          width: 48.0,
          alignment: Alignment.center,
          child: Text(
            randomNumber.toString(),
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            color: cellColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
    }).toList());

    return cells;
  }
}