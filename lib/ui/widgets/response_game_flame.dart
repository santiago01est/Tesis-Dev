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
      child: BlocBuilder<InstruccionesCubit, List<String>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: movementInstructionsCubit.state.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(movementInstructionsCubit.state[index]),
              );
            },
          );
        },
      ),
    );
  }
}