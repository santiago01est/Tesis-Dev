import 'dart:math'; // Importa la librería math para generar números aleatorios

import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SeguimientoProfesorScreen extends StatelessWidget {

  const SeguimientoProfesorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cursoCubit= context.read<CursoCubit>();
    final estudiantes= cursoCubit.state.estudiantes!;
    return Scaffold(
        appBar: AppBar(
          title: Text('Resultados'),
        ),
           body: DataTableWidget(estudiantes: estudiantes),
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

  // Agregar columna para el promedio
  columns.add(DataColumn(label: Text('Promedio')));

  return columns;
}
  List<DataRow> _buildRows() {
  Random random = Random();
  return widget.estudiantes.map((student) {
    int rowIndex = widget.estudiantes.indexOf(student);
    return DataRow(
      cells: _buildCells( student.nombre!, rowIndex, random),
    );
  }).toList();
}

List<DataCell> _buildCells(String student, int rowIndex, Random random) {
  List<DataCell> cells = [];

  // Agregar la celda con el nombre del estudiante
  cells.add(DataCell(Text(student)));

  // Agregar las celdas para las actividades con números aleatorios
  List<int> activityValues = []; // Lista para almacenar los valores de actividades
  activities.forEach((activity) {
    int randomNumber = random.nextInt(4) + 1;
    Color cellColor = asignarColor(activities.indexOf(activity));

    cells.add(
      DataCell(
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
      ),
    );

    // Agregar el valor numérico de la actividad a la lista
    activityValues.add(randomNumber);
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
  if(colIndex < 4){

    return Colors.green;
  }else if(colIndex >= 4 && colIndex<8){
    return Colors.orange;
  }else{
    return Colors.blue;
  }

}
}