import 'package:dev_tesis/ui/pages/screen_actividad/crearActividad.dart';
import 'package:dev_tesis/ui/pages/screen_curso/seguimiento_estudiante_screen.dart';
import 'package:dev_tesis/ui/pages/screen_curso/seguimiento_profesor_screen.dart';
import 'package:dev_tesis/ui/pages/screen_home/home.dart';
import 'package:dev_tesis/ui/pages/screen_laberintos/actividad_cuestionario.dart';
import 'package:dev_tesis/ui/pages/screen_laberintos/nivel1_screen.dart';
import 'package:dev_tesis/ui/pages/screen_curso/panel_curso_screen.dart';
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
      builder: (context, state) => welcome(),
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
        final String cursoId = state.pathParameters['cursoId'] ?? '1';
        return PanelCursoScreen(cursoId: cursoId);
      },
    ),
    GoRoute(
       path: '/laberinto/:actividadId',
      builder: (context, state) { 
        final String actividadId = state.pathParameters['actividadId'] ?? '-1';
        return Laberinto(actividadId: actividadId);}
    ),

    GoRoute(
      path: '/cuestionario/:actividadId',
      builder: (context, state) { 
        final String actividadId = state.pathParameters['actividadId'] ?? '1';
        return ActividadCuestionarioScreen(actividadId: actividadId);}
    ),

    GoRoute(
      path: '/panelprofesor/:profesorId',
      builder: (context, state) {
        // Obtén el ID del profesor desde los parámetros de la ruta
        final String profesorId = state.pathParameters['profesorId'] ?? '1';
        return PanelPrincipalProfesorScreen(profesorId: profesorId);
      },
    ),
    GoRoute(
      path: '/estudiocuestionario/:unidadId',
      builder: (context, state) {
        // se valida que sea profesor y que este logueado
 
        final String unidadId = state.pathParameters['unidadId'] ?? '0';
        return CrearActividad(unidadId: unidadId);
        }
    ),
       GoRoute(
      path: '/seguimientoprofesor/:cursoId',
      builder: (context, state){
        final String cursodId = state.pathParameters['cursoId'] ?? '0';
        return SeguimientoProfesorScreen(cursoId: cursodId);
      }
    ),
    GoRoute(
      path: '/seguimientoestudiante/:cursoId',
      builder: (context, state){
        final String cursodId = state.pathParameters['cursoId'] ?? '0';
        return SeguimientoEstudianteScreen(cursoId: cursodId);
      }
    ),
     GoRoute(
      path: '/testautopercepcion/:cursoId',
      builder: (context, state){
        final String cursodId = state.pathParameters['cursoId'] ?? '0';
        return TestAutoPercepcionScreen(cursoId: '1');
      }
    ),
  ],
);
