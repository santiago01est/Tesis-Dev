import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/widgets/PopUp.dart';
import 'package:dev_tesis/utils/rutasImagenes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListaEstudiantesWidget extends StatefulWidget {
  const ListaEstudiantesWidget({super.key});

  @override
  State<ListaEstudiantesWidget> createState() => _ListaEstudiantesWidgetState();
}

class _ListaEstudiantesWidgetState extends State<ListaEstudiantesWidget> {
  @override
  Widget build(BuildContext context) {
    int indiceEstudiante = 0;
    final cursoCubit = context.watch<CursoCubit>();

    void actualizarAvatarEstudiante(String avatarPath) {
      setState(() {
        Curso curso = cursoCubit.state;
        curso.estudiantes![indiceEstudiante].avatar = avatarPath;
        cursoCubit.actualizarCurso(curso);
      });
    }

    void eliminarEstudiante(int index) {
      setState(() {
        Curso curso = cursoCubit.state;
        curso.estudiantes!.removeAt(index);
        cursoCubit.actualizarCurso(curso);
      });
    }

    return SizedBox(
      height: 100,
      child: FractionallySizedBox(
        // si el ancho de la pantalla es menor a 700 es un dispositivo movil
        widthFactor: MediaQuery.of(context).size.width < 700 ? 0.9 : 0.6,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 100,
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
                          BlocBuilder<CursoCubit, Curso>(
                            builder: (context, state) {
                              if (state.estudiantes != null &&
                                  state.estudiantes!.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.estudiantes!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: InkWell(
                                        onTap: () {
                                          indiceEstudiante = index;
                                          PopupUtils.showAvatarSelectionPopup(
                                              context,
                                              RutasImagenes.getRutasAvatares(),
                                              actualizarAvatarEstudiante);
                                        },
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(state
                                              .estudiantes![index].avatar!),
                                        ),
                                      ),
                                      title: Text(
                                          state.estudiantes![index].nombre!),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: orangeColor),
                                        onPressed: () {
                                          //eliminarEstudiante(index);
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else {
                                // Manejo del caso en el que no hay estudiantes
                                return Text('No hay estudiantes');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
