import 'package:dev_tesis/config/config.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:flutter/material.dart';
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: "Codex",
      theme: ThemeData(
        scaffoldBackgroundColor: sixtyColor,
        textTheme: GoogleFonts.ibmPlexMonoTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primaryColor: Colors.blue,
      ),
    );
  }
}
