import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBarProfesorPanel extends StatelessWidget
    implements PreferredSizeWidget {
  final int profesorId;

  const AppBarProfesorPanel({
    super.key,
    required this.profesorId
  });

  @override
  Widget build(BuildContext context) {
    final profesorCubit = context.watch<ProfesorCubit>();
    final router = GoRouter.of(context);
    return AppBar(
      backgroundColor: blueColor, // Ajusta el color según tus necesidades
      title: const SubtitleText(text: 'Mundo PC'),
      actions: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Verifica el ancho de la pantalla
            if (constraints.maxWidth > 600) {
              // Pantalla grande: muestra el nombre y el avatar
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          router.go('/home');
                        },
                        child: const SubtitleText(text: 'Inicio')),
                    
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      profesorCubit.state.nombre ?? '',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // print('Avatar tap');
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
