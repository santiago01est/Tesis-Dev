import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RespuestaLaberinto extends StatefulWidget {
  const RespuestaLaberinto({Key? key}) : super(key: key);

  @override
  State<RespuestaLaberinto> createState() => _RespuestaLaberintoState();
}

class _RespuestaLaberintoState extends State<RespuestaLaberinto> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movementInstructionsCubit = context.watch<InstruccionesCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ajustar la posición del ScrollController al final del SingleChildScrollView
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(
            movementInstructionsCubit.state.length,
            (index) {
              final valor = movementInstructionsCubit.state[index].value;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      valor,
                      height: 60,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
