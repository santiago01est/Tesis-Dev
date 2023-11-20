import 'package:dev_tesis/ui/pages/screen_home/home.dart';
import 'package:dev_tesis/ui/pages/screen_registro_profesor/inicio_sesion_screen.dart';
import 'package:dev_tesis/ui/pages/screen_registro_profesor/registro_profesor_screen.dart';
import 'package:dev_tesis/ui/pages/screen_welcome/welcome.dart';
import 'package:dev_tesis/ui/pages/scren_crear_curso/crear_curso_bienvenida.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const welcome(),
    ),
    GoRoute(
      path: '/inicio',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/iniciosesion',
      builder: (context, state) => const InicioSesionScreen(),
    ),
    GoRoute(
      path: '/registroprofesor',
      builder: (context, state) => const RegistroProfesorScreen(),
    ),
    GoRoute(
      path: '/crearcurso',
      builder: (context, state) => const CrearCursoBienvenidaScreen(),
    ),
  ],
);
