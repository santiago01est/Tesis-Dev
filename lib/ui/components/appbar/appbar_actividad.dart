import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBarActividad extends StatelessWidget
    implements PreferredSizeWidget {
  final String cursoName;
  final String cursoId;
  final String userName;
  final List<String> userAvatars;
  final Function onLogout;

  const CustomNavigationBarActividad({
    super.key,
    required this.cursoName,
    required this.cursoId,
    required this.userName,
    required this.userAvatars,
    required this.onLogout,
  });

  

  @override
  Widget build(BuildContext context) {

    late InitData cs_init = InitData(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );


    final estudiantesCubit = context.read<EstudiantesCubit>();
    final router = GoRouter.of(context);
    return AppBar(
      title: Text(cursoName),
      actions: [
        // Aquí puedes mostrar el avatar cuando esté listo
        Center(
          child: GestureDetector(
            onTap: () {
              router.go('/panelcurso/${cursoId}');
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SubtitleText(text: 'Curso'),
            ),
          ),
        ),
        SizedBox(width: 50),

        Center(child: SubtitleText(text: userName)),
        SizedBox(width: 10),

        FutureBuilder<List<String>>(
          future: _fetchAvatar(estudiantesCubit.state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!.map((avatarPath) {
                    return CircleAvatar(
                      backgroundImage: AssetImage(avatarPath),
                    );
                  }).toList(),
                );
              } else {
                return Icon(Icons.error); // Manejo de error
              }
            }
          },
        ),
        SizedBox(width: 10),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Cerrar sesión'),
                value: 'Opción 1',
                onTap: () {
                  _showLogoutMenu(context, cs_init);
                },
              ),
              
              // Add more PopupMenuItems as needed
            ];
          },
          onSelected: (value) {
            // Handle selection
          },
        ),
      ],
    );
  }

  // Este método simula la carga del avatar
  Future<List<String>> _fetchAvatar(List<Estudiante> state) async {
    List<String> avatares = [];
    for (var estudiante in state) {
      avatares.add(estudiante.avatar!);
    }

    return avatares; // Ruta del avatar
  }

  void _showLogoutMenu(BuildContext context, InitData cs_init) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () {
                cs_init.cerrarSesionEstudiante('idsEstudiantes');
                Navigator.pop(context); // Cerrar el menú
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
