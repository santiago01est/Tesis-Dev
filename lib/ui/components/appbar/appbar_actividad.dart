import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavigationBarActividad extends StatelessWidget implements PreferredSizeWidget {
  final String cursoName;
  final String userName;
  final List<String> userAvatars;
  final Function onLogout;

  const CustomNavigationBarActividad({
    super.key,
    required this.cursoName,
    required this.userName,
    required this.userAvatars,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final estudiantesCubit = context.read<EstudiantesCubit>();
    return AppBar(
      title: Text(cursoName),
          actions: [
            // Aquí puedes mostrar el avatar cuando esté listo
            Center(child: Text(userName)),
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
          ],
    );
  }

    // Este método simula la carga del avatar
  Future<List<String>> _fetchAvatar(List<Estudiante> state) async {

     List<String> avatares=[];
    for (var estudiante in state) {
      avatares.add(estudiante.avatar!);
    } 
     
    return avatares; // Ruta del avatar
  }

  void _showLogoutMenu(BuildContext context) {
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
                onLogout(); // Llamar a la función de cierre de sesión
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


