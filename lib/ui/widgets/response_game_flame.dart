import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RespuestaLaberinto extends StatelessWidget {
  const RespuestaLaberinto({super.key});

  @override
  Widget build(BuildContext context) {
    final movementInstructionsCubit = context.watch<InstruccionesCubit>();
    return Container(
      margin: const EdgeInsets.all(30),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6, // Cambia esto según la cantidad deseada de columnas
          mainAxisSpacing: 8.0
        ),
        itemCount: movementInstructionsCubit.state.length,
        itemBuilder: (context, index) {
          final clave = movementInstructionsCubit.state[index].key;
          final valor = movementInstructionsCubit.state[index].value;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(clave),
                Image.asset(
                    valor,
                    width: 60, // Ajusta el tamaño de la imagen según sea necesario
                    height: 60,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}