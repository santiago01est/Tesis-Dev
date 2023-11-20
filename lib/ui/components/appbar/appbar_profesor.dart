import 'package:flutter/material.dart';

class AppBarProfesor extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;
  final String avatarImagePath;
  final VoidCallback onAvatarTap;

  const AppBarProfesor({
    super.key,
    required this.title,
    required this.userName,
    required this.avatarImagePath,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue, // Ajusta el color según tus necesidades
      title: Text(title),
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
                    Text(userName),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: onAvatarTap,
                      child: CircleAvatar(
                        radius:
                            20, // Ajusta el radio del avatar según tus necesidades
                        backgroundImage: AssetImage(avatarImagePath),
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
                  onTap: onAvatarTap,
                  child: CircleAvatar(
                    radius:
                        20, // Ajusta el radio del avatar según tus necesidades
                    backgroundImage: AssetImage(avatarImagePath),
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
