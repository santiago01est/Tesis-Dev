import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final String platformName;
  final String userName;
  final List<String> userAvatars;
  final Function onLogout;

  const CustomNavigationBar({
    super.key,
    required this.platformName,
    required this.userName,
    required this.userAvatars,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(platformName),
          Row(
            children: [
              
            
                CircleAvatar(
                  radius: 20, // Ajusta el radio del avatar según tus necesidades
                  backgroundImage: AssetImage('avatar'), // Establece la imagen de fondo del avatar
                ),
              SizedBox(width: 8), // Espacio entre el avatar y el nombre
              Text(userName), // Nombre del usuario
              IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _showLogoutMenu(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
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
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}


