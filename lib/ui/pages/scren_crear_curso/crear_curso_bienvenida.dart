import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrearCursoBienvenidaScreen extends StatefulWidget {
  const CrearCursoBienvenidaScreen({super.key});

  @override
  State<CrearCursoBienvenidaScreen> createState() =>
      _CrearCursoBienvenidaScreenState();
}

class _CrearCursoBienvenidaScreenState
    extends State<CrearCursoBienvenidaScreen> {
  @override
  Widget build(BuildContext context) {
    final nombreCompleto = context.watch<NombreCompletoCubit>();
    return Scaffold(
        appBar: AppBarProfesor(
          title: 'Mundo PC',
          userName: nombreCompleto.state,
          avatarImagePath: 'assets/items/perico_mascota.png',
          onAvatarTap: () {
            print('Avatar tap');
          },
        ),
        body: const Center());
  }
}
