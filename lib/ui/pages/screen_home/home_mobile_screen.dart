import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/components/cards/curso_cards.dart';
import 'package:dev_tesis/ui/widgets/PopUp.dart';
import 'package:flutter/material.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  late InitData _cursosProfesoresCasoUso;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _cursosProfesoresCasoUso = InitData(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );
    _cursosProfesoresCasoUso.obtenerCursosYProfesores();
    _simularCarga();
  }

  Future<void> _simularCarga() async {
    // Simular una carga de 5 segundos
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final profesoresCubit = context.watch<ProfesoresCubit>();
    final profesores = profesoresCubit.state;
    final rolCubit = context.watch<RolCubit>();
    return _isLoading
        ? const SizedBox(
            width: 100,
            height: 100,
            child: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: blueColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/fondos/FondoHome.png'), // Ruta de tu imagen de fondo
                        fit: BoxFit.cover, // Ajuste para cubrir el contenedor
                      ),
                    ),

                    // Contenido superpuesto en la primera sección
                    child: Column(
                      children: [
                        // Fila con botón en la parte superior derecha
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PixelLargeBttn(
                              path: 'assets/items/ButtonOrange.png',
                              onPressed: () {
                                router.go('/registroprofesor');
                              },
                              text: 'REGISTRARSE',
                            ),
                          ],
                        ),

                        // Fila con dos secciones
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sección de la izquierda con texto y botón
                              Image.asset(
                                width: 200,
                                height: 50,
                                'assets/logomundopc.png',
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(height: 20.0),
                              const Text(
                                  'Mundo PC es más que una plataforma; somos un puente entre la innovación, la creatividad y la enseñanza.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  )),
                              PixelLargeBttn(
                                path: 'assets/items/ButtonBlue.png',
                                onPressed: () {
                                  router.go('/registroprofesor');
                                },
                                text: 'INICIAR SESIÓN',
                              ),
                            ],
                          ),
                        ),
                        // Sección de la derecha con imagen

                        Image.asset(
                          'assets/ImagenMascotasHome.png',
                          fit: BoxFit.contain,
                          width: 400,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Barra de búsqueda redondeada
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Center(
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  children: [
                                    // Icono de lupa
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.search),
                                    ),
                                    // Campo de texto de búsqueda
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Buscar Curso...',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: BlocBuilder<BDCursosCubit, List<Curso>>(
                              builder: (context, cursos) {
                                if (cursos.isEmpty) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 8.0, // Espacio entre las imágenes
                                    runSpacing: 8.0,
                                    children: List.generate(
                                      cursos.length,
                                      (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (rolCubit.state == 'profesor') {
                                              router.push(
                                                  '/panelcurso/${cursos[index].id}');
                                            } else {
                                              if(context.read<EstudiantesCubit>().state.isEmpty){
                                                  PopupUtils.showCodeAccessPopup(
                                                    context, cursos[index]);

                                                }else{
                                                  router.push(
                                                      '/panelcurso/${cursos[index].id}');
                                                }
                                            }
                                          },
                                          child: CursoCard(
                                            curso: cursos[index],
                                            nombreProfesor:
                                                obtenerNombreProfesor(
                                                    profesores,
                                                    cursos[index].profesor!),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  obtenerNombreProfesor(List<Profesor> profesores, String idProfesor) {
    print(profesores.length);
    print('profesorid: $idProfesor');
    // for que retorna el nombre del profesor
    for (var i = 0; i < profesores.length; i++) {
      if (profesores[i].id == idProfesor) {
        return profesores[i].nombre;
      }
    }
    return '';
  }
}
