import 'package:dev_tesis/config/config.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/domain/repository/profesor_respository.dart';
import 'package:dev_tesis/domain/repository/unidad_repository.dart';
import 'package:dev_tesis/firebase_options.dart';
import 'package:dev_tesis/infraestructure/driven_adapter/profesor_adapter/profesor_data_adapter.dart';
import 'package:dev_tesis/infraestructure/driven_adapter/unidad_adapter/unidad_data_adapter.dart';
import 'package:dev_tesis/ui/bloc/actividad_custio_test.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/bd_demo.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/styles.dart';
import 'package:get_it/get_it.dart';
import 'infraestructure/driven_adapter/cursos_adapter/cursos_data_adapter.dart';

final getIt = GetIt.instance;

void setupDependencies(BuildContext context) {
  // Registra tus dependencias aquí
  getIt.registerSingleton<CursoRepository>(CursosDataAdapter());
  getIt.registerSingleton<CursosCasoUso>(
      CursosCasoUso(cursoRepository: getIt<CursoRepository>()));

  getIt.registerSingleton<UnidadRepository>(UnidadDataAdapter());
  getIt.registerSingleton<UnidadCasoUso>(
      UnidadCasoUso(getIt<UnidadRepository>()));

  getIt.registerSingleton<ProfesorRepository>(ProfesorDataAdapter());
  getIt.registerSingleton<ProfesorCasoUso>(
      ProfesorCasoUso(profesorRepository: getIt<ProfesorRepository>()));
}

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupDependencies(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<CursoCubit>(create: (context) => CursoCubit()),
        // Agrega más BlocProviders según sea necesario
        BlocProvider<ProfesorCubit>(
          create: (context) => ProfesorCubit(),
        ),
        BlocProvider<ProfesoresCubit>(
          create: (context) => ProfesoresCubit(),
        ),
        BlocProvider<BDCursosCubit>(
          create: (context) => BDCursosCubit(),
        ),
        BlocProvider<BDemoMundoPC>(
          create: (context) => BDemoMundoPC(),
        ),
        BlocProvider<RolCubit>(
          create: (context) => RolCubit(),
        ),
        BlocProvider<InstruccionesCubit>(
          create: (context) => InstruccionesCubit(),
        ),
        BlocProvider<UnidadesCubit>(
          create: (context) => UnidadesCubit(),
        ),
        BlocProvider<ActividadCuestionarioCubit>(
          create: (context) => ActividadCuestionarioCubit(),
        ),

        BlocProvider<EstudiantesCubit>(
          create: (context) => EstudiantesCubit(),
        ),
        BlocProvider<SeguimientosEstudiantesCubit>(
          create: (context) => SeguimientosEstudiantesCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: "Mundo PC",
        theme: ThemeData(
          scaffoldBackgroundColor: sixtyColor,
          textTheme: GoogleFonts.lexendExaTextTheme(Theme.of(context).textTheme)
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
