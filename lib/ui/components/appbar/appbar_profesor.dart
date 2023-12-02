import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarProfesor extends StatelessWidget implements PreferredSizeWidget {
  const AppBarProfesor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profesorCubit = context.watch<ProfesorCubit>();
    return AppBar(
      backgroundColor: Colors.blue, // Ajusta el color según tus necesidades
      title: Text('Mundo PC'),
      actions: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Verifica el ancho de la pantalla
            if (constraints.maxWidth > 600) {
              // Pantalla grande: muestra el nombre y el avatar
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profesorCubit.state.nombre ?? '',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Avatar tap');
                      },
                      child: CircleAvatar(
                        radius:
                            20, // Ajusta el radio del avatar según tus necesidades
                        backgroundImage: AssetImage(
                          profesorCubit.state.avatar ?? '',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Pantalla pequeña: solo muestra el avatar
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    print('Avatar tap');
                  },
                  child: CircleAvatar(
                    radius:
                        20, // Ajusta el radio del avatar según tus necesidades
                    backgroundImage: AssetImage(
                      profesorCubit.state.avatar ?? '',
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
