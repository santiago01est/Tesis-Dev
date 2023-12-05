import 'package:dev_tesis/config/config.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/styles.dart';

import 'package:get_it/get_it.dart';

import 'infraestructure/driven_adapter/cursos_adapter/cursos_data_adapter.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Registra tus dependencias aquí
  getIt.registerSingleton<CursoRepository>(CursosDataAdapter());
  getIt.registerSingleton<CursosCasoUso>(
      CursosCasoUso(getIt<CursoRepository>()));
}

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CursoCubit>(create: (context) => CursoCubit()),
        // Agrega más BlocProviders según sea necesario
        BlocProvider<ProfesorCubit>(
          create: (context) => ProfesorCubit(),
        ),
        BlocProvider<BDCursosCubit>(
          create: (context) => BDCursosCubit(),
        ),
        BlocProvider<InstruccionesCubit>(
          create: (context) => InstruccionesCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: "Codex",
        theme: ThemeData(
          scaffoldBackgroundColor: sixtyColor,
          textTheme:
              GoogleFonts.ibmPlexMonoTextTheme(Theme.of(context).textTheme)
                  .apply(bodyColor: Colors.black),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primaryColor: blueDarkColor,
        ),
      ),
    );
  }
}
