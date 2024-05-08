import 'package:dev_tesis/ui/pages/screen_actividad/crearActividad.dart';
import 'package:dev_tesis/ui/pages/screen_curso/seguimiento_estudiante_screen.dart';
import 'package:dev_tesis/ui/pages/screen_curso/seguimiento_profesor_screen.dart';
import 'package:dev_tesis/ui/pages/screen_home/home.dart';
import 'package:dev_tesis/ui/pages/screen_laberintos/actividad_cuestionario.dart';
import 'package:dev_tesis/ui/pages/screen_laberintos/actividad_desconectada.dart';
import 'package:dev_tesis/ui/pages/screen_laberintos/nivel1_screen.dart';
import 'package:dev_tesis/ui/pages/screen_curso/panel_curso_screen.dart';
import 'package:dev_tesis/ui/pages/screen_laberintos/test.dart';
import 'package:dev_tesis/ui/pages/screen_panel_profesor_curso/panel_profesor_principal.dart';
import 'package:dev_tesis/ui/pages/screen_registro_profesor/inicio_sesion_screen.dart';
import 'package:dev_tesis/ui/pages/screen_registro_profesor/registro_profesor_screen.dart';
import 'package:dev_tesis/ui/pages/screen_test_autopercepcion/test_auto_screen.dart';
import 'package:dev_tesis/ui/pages/screen_welcome/welcome.dart';
import 'package:dev_tesis/ui/pages/scren_crear_curso/crear_curso_bienvenida.dart';
import 'package:dev_tesis/ui/pages/scren_crear_curso/crear_curso_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Welcome(),
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
      path: '/crearcursobienvenida',
      builder: (context, state) => const CrearCursoBienvenidaScreen(),
    ),
    GoRoute(
      path: '/crearcurso',
      builder: (context, state) => const CrearCursoScreen(),
    ),
    // ruta con id del curso
    GoRoute(
      path: '/panelcurso/:cursoId', // :cursoId indica un parámetro dinámico
      builder: (context, state) {
        // Obtén el ID del curso desde los parámetros de la ruta
        final String cursoId = state.pathParameters['cursoId'] ?? '-1';
        int cursoIdInt = int.parse(cursoId);
        return PanelCursoScreen(cursoId: cursoIdInt);
      },
    ),
    GoRoute(
        path: '/laberinto/:actividadId',
        builder: (context, state) {
          final String actividadId =
              state.pathParameters['actividadId'] ?? '-1';
          int actividadIdInt = int.parse(actividadId);
          return Laberinto(actividadId: actividadIdInt);
        }),

    GoRoute(
        path: '/cuestionario/:actividadId',
        builder: (context, state) {
          final String actividadId = state.pathParameters['actividadId'] ?? '1';
          int actividadIdInt = int.parse(actividadId);
          return ActividadCuestionarioScreen(actividadId: actividadIdInt);
        }),

    GoRoute(
        path: '/desconectada/:actividadId',
        builder: (context, state) {
          final String actividadId = state.pathParameters['actividadId'] ?? '1';
          int actividadIdInt = int.parse(actividadId);
          return ActividadDesconectadaScreen(actividadId: actividadIdInt);
        }),

    GoRoute(
      path: '/panelprofesor/:profesorId',
      builder: (context, state) {
        // Obtén el ID del profesor desde los parámetros de la ruta
        final String profesorId = state.pathParameters['profesorId'] ?? '1';
        int profesorIdInt = int.parse(profesorId);
        return PanelPrincipalProfesorScreen(profesorId: profesorIdInt);
      },
    ),
    GoRoute(
        path: '/estudiocuestionario/:unidadId',
        builder: (context, state) {
          // se valida que sea profesor y que este logueado
          
          final String unidadId = state.pathParameters['unidadId'] ?? '-1';
          int unidadIdInt = int.parse(unidadId);
          return CrearActividad(
              unidadId: unidadIdInt);
        }),
    GoRoute(
        path: '/seguimientoprofesor/:cursoId',
        builder: (context, state) {
          final String cursoId = state.pathParameters['cursoId'] ?? '-1';
          int cursoIdInt = int.parse(cursoId);
          return SeguimientoProfesorScreen(cursoId: cursoIdInt);
        }),
    GoRoute(
        path: '/seguimientoestudiante/:cursoId',
        builder: (context, state) {
          final String cursoId = state.pathParameters['cursoId'] ?? '-1';
          int cursoIdInt = int.parse(cursoId);
          return SeguimientoEstudianteScreen(cursoId: cursoIdInt);
        }),
    GoRoute(
        path: '/testautopercepcion/:cursoId',
        builder: (context, state) {
          final String cursoId = state.pathParameters['cursoId'] ?? '-1';
          int cursoIdInt = int.parse(cursoId);
          return TestAutoPercepcionScreen(cursoId: cursoIdInt);
        }),
  ],
);
