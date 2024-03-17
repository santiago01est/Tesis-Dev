import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';

class CursosDataAdapter extends CursoRepository {
  @override
  Future<List<Curso>> getCursos() {
    /* TODO: implement getCursos BD mientras sera por mapas */

    Curso c1 = Curso(
        id: '1',
        nombre: 'Curso Quinto C',
        codigoAcceso: '1234',
        departamento: 'Quindío',
        ciudad: 'Calarca',
        colegio: 'IE General Santander',
        profesor: '1',
        portada: 'assets/fondos/FondoInicio.png',
        estado: true,
        numEstudiantes: 10,
        descripcion:
            "Este es un espacio para el desarrollo y evaluacion del pensamiento computacional, para el grupo Quinto C. Donde puedes aprender y divertirte en el mundo de los algoritmos, los patrones y más.",
        fechaCreacion: '2023-12-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(
              id: '0',
              nombre: 'Unidad Cero - Diagnóstico',
              estado: 'Activa',
              actividades: [
                ActividadCuestionario(
                    id: '1',
                    nombre: 'Actividad 01',
                    estado: 'Activa',
                    descripcion:
                        'Lleva al pollito con su mamá \nRecoge la flor por el camino \nCuidado con el gato: no pases por su casilla',
                    tipoActividad: 'Cuestionario',
                    dimension: 3,
                    casillas: [3, -1, -1, -1, 7, 23, -1, -1, 13],
                    ejemploImage: 'ejemploUnidad0.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'Avanzar.png',
                        'Abajo.png',
                        'Avanzar.png',
                        'Abajo.png',
                      ],
                      [
                        'Avanzar.png',
                        'Abajo.png',
                        'Abajo.png',
                        'Avanzar.png',
                      ],
                      ['Avanzar.png', 'Avanzar.png', 'Abajo.png', 'Abajo.png'],
                      [
                        'Avanzar.png',
                        'Abajo.png',
                        'Avanzar.png',
                      ]
                    ],
                    respuestaCorrecta: 2),
                ActividadCuestionario(
                    id: '2',
                    nombre: 'Actividad 02',
                    estado: 'Activa',
                    descripcion:
                        'Lleva al pollito con su mamá \nRecoge la flor por el camino \nCuidado con el gato: no pases por su casilla',
                    tipoActividad: 'Cuestionario',
                    dimension: 3,
                    casillas: [3, -1, -1, -1, 7, 23, -1, -1, 13],
                    ejemploImage: 'ejemploUnidad0A2.png',
                    ejercicioImage:
                        'assets/items/ejemplosImg/ejercicioImage02.png',
                    respuestas: [
                      [
                        'Abajo.png',
                        'Abajo.png',
                        'Avanzar.png',
                        'Avanzar.png',
                      ],
                      [
                        'Avanzar.png',
                        'Abajo.png',
                        'Avanzar.png',
                        'Abajo.png',
                      ],
                      [
                        'Abajo.png',
                        'Avanzar.png',
                      ],
                      [
                        'Abajo.png',
                        'Avanzar.png',
                        'Abajo.png',
                        'Avanzar.png',
                      ]
                    ],
                    respuestaCorrecta: 2),
                ActividadCuestionario(
                    id: '3',
                    nombre: 'Actividad 03',
                    estado: 'Activa',
                    descripcion:
                        'Lleva al pollito con su mamá.\nRecoge la flor por el camino.\nCuidado con el gato: no pases por su casilla.',
                    tipoActividad: 'Cuestionario',
                    dimension: 4,
                    casillas: [-1, -1, -1, -1, 
                    13, 23, 7, 3, 
                    -1, -1, -1, -1,
                    -1, -1, -1, -1],
                    ejemploImage: 'ejemploUnidad0.png',
                    ejercicioImage: '',
                    respuestas: [
                      [
                        'Izquierda.png',
                        'Abajo.png',
                        'Izquierda.png',
                        'Izquierda.png',
                        'Arriba.png',
                      ],
                      [
                        'Izquierda.png',
                        'Arriba.png',
                        'Izquierda.png',
                        'Abajo.png',
                      ],
                      [
                        'Izquierda.png',
                        'Arriba.png',
                        'Izquierda.png',
                        'Abajo.png',
                        'Izquierda.png'
                      ],
                      [
                        'Arriba.png',
                        'Izquierda.png',
                        'Izquierda.png',
                        'Izquierda.png',
                        'Abajo.png',
                      ]
                    ],
                    respuestaCorrecta: 2),
              ]),
          Unidad(id: '1', nombre: 'Unidad Uno', estado: 'Activa', actividades: [
            ActividadLaberinto(
                id: '11',
                nombre: 'Primeros Pasos',
                estado: 'Activa',
                descripcion:
                    'Hola El granjero necesita de tu ayuda! Guíalo a encontrar a su GALLINA.',
                tipoActividad: 'Laberinto',
                nombreArchivo: "Laberinto1"),
            ActividadCuestionario(
                id: '12',
                nombre: 'Buscando el mejor camino',
                estado: 'Activa',
                descripcion:
                    'Ayuda a Juan a encontrar el camino al saco de café que ha recolectado.',
                tipoActividad: 'Cuestionario',
                dimension: 6,
                 ejemploImage: 'ejemplo_simple_secuencia.png',
                ejercicioImage: '',
                casillas: [
                  1,15,15,15,15,15,
                  -1,-1,15,15,15,15,
                  -1,-1,-1,15,-1,-1,
                  6,-1,15,15,15,-1,
                  -1,15,15, -1,-1,15,
                  20,-1,-1,15,15,-1
                ],
                respuestas: [
                  [
                    'Avanzar.png',
                    'Avanzar.png',
                    'Avanzar.png',
                    'Avanzar.png',
                  ],
                  [
                    'Avanzar.png',
                    'Avanzar.png',
                    'Avanzar.png',
                    'Avanzar.png',
                    'Avanzar.png',
                  ],
                  ['Avanzar.png', 'Avanzar.png', 'Avanzar.png'],
                  [
                    'Avanzar.png',
                    'Avanzar.png',
                  ]
                ],
                respuestaCorrecta: 2),
            ActividadLaberinto(
                id: '13',
                nombre: 'Primeros Pasos',
                estado: 'Activa',
                descripcion:
                    'Hola El granjero necesita de tu ayuda! Guíalo a encontrar a la CALABAZA.',
                tipoActividad: 'Laberinto',
                nombreArchivo: "Laberinto2"),
            Actividad(
              id: '4',
              nombre: 'Adelante, giro, adelante',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Cuestionario',
            ),
            Actividad(
              id: '5',
              nombre: 'Hora del café',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad Dos', estado: 'Activa', actividades: [
            Actividad(
              id: '21',
              nombre: 'El mejor camino',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '22',
              nombre: 'Recoge las recompensas',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '23',
              nombre: 'Diversión en clase',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '24',
              nombre: 'Si pasa esto hago aquello',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '25',
              nombre: 'Estoy en un ciclo',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(
              id: '3',
              nombre: 'Unidad Tres',
              estado: 'Activa',
              actividades: [
                Actividad(
                  id: '31',
                  nombre: 'Mi decision',
                  estado: 'Activa',
                  descripcion: '',
                  tipoActividad: 'Laberinto',
                ),
                Actividad(
                  id: '32',
                  nombre: 'Recoge todas las recompensas',
                  estado: 'Activa',
                  descripcion: '',
                  tipoActividad: 'Laberinto',
                ),
                Actividad(
                  id: '33',
                  nombre: 'Diversión en clase',
                  estado: 'Activa',
                  descripcion: '',
                  tipoActividad: 'Laberinto',
                ),
                Actividad(
                  id: '34',
                  nombre: 'Si pasa esto hago aquello',
                  estado: 'Activa',
                  descripcion: '',
                  tipoActividad: 'Laberinto',
                ),
                Actividad(
                  id: '35',
                  nombre: 'Estoy en un ciclo',
                  estado: 'Activa',
                  descripcion: '',
                  tipoActividad: 'Laberinto',
                ),
              ])
        ],
        estudiantes: [
          Estudiante(
              nombre: 'Andres Perez Perez',
              avatar: 'assets/avatares/aguila_avatar.png'),
          Estudiante(
            nombre: 'Sofia González Perez',
            avatar: 'assets/avatares/orquidea_avatar.png',
          ),
          Estudiante(
            nombre: 'Nicolas Rodriguez Hernandez',
            avatar: 'assets/avatares/pollitos_avatar.png',
          ),
          Estudiante(
            nombre: 'Sergio Torres Diaz',
            avatar: 'assets/avatares/osoanteojos_avatar.png',
          ),
          Estudiante(
            nombre: 'Estefania Gutierrez Gutierrez',
            avatar: 'assets/avatares/chiguiro_avatar.png',
          ),
          Estudiante(
            nombre: 'Camila Salazar Salazar',
            avatar: 'assets/avatares/mujergranjera_avatar.png',
          )
        ]);
    Curso c2 = Curso(
        id: '2',
        nombre: 'Curso Cuarto B',
        codigoAcceso: '1234',
        departamento: 'Huila',
        ciudad: 'Neiva',
        colegio: 'Camilo Torres',
        profesor: '2',
        portada: 'assets/fondos/FondoNevado.png',
        estado: true,
        numEstudiantes: 10,
        descripcion:
            "Espacio de aprendizaje para mis estudiantes de cuarto grado para mejorar el pensamiento computacional",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ],
        estudiantes: [
          Estudiante(
              nombre: 'Andres Perez Perez',
              avatar: 'assets/avatares/finca_avatar.png'),
          Estudiante(
            nombre: 'Sofia González Perez',
            avatar: 'assets/avatares/indio_avatar.png',
          ),
          Estudiante(
            nombre: 'Nicolas Rodriguez Hernandez',
            avatar: 'assets/avatares/cultivo_avatar.png',
          ),
          Estudiante(
            nombre: 'Sergio Torres Diaz',
            avatar: 'assets/avatares/gato_avatar.png',
          ),
          Estudiante(
            nombre: 'Estefania Gutierrez Gutierrez',
            avatar: 'assets/granjeroboy_avatar.png',
          ),
          Estudiante(
            nombre: 'Camila Salazar Salazar',
            avatar: 'assets/avatares/gato_avatar.png',
          )
        ]);
    Curso c3 = Curso(
        id: '3',
        nombre: 'Curso Tercero A',
        codigoAcceso: '12345',
        departamento: 'Departamento 3',
        ciudad: 'Ciudad 3',
        colegio: 'Colegio 3',
        profesor: '3',
        portada: 'assets/fondos/FondoHome.png',
        estado: true,
        numEstudiantes: 10,
        descripcion:
            "Curso para mis estudiantes de Tercer grado para el desarrollo del pensamiento computacional",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ],
        estudiantes: [
          Estudiante(
              nombre: 'Andres Perez Perez',
              avatar: 'assets/avatares/gato_avatar.png'),
          Estudiante(
            nombre: 'Sofia González Perez',
            avatar: 'assets/avatares/perico_avatar.png',
          ),
          Estudiante(
            nombre: 'Nicolas Rodriguez Hernandez',
            avatar: 'assets/avatares/chiguiro_avatar.png',
          ),
          Estudiante(
            nombre: 'Sergio Torres Diaz',
            avatar: 'assets/avatares/gato_avatar.png',
          ),
          Estudiante(
            nombre: 'Estefania Gutierrez Gutierrez',
            avatar: 'assets/avatares/gato_avatar.png',
          ),
          Estudiante(
            nombre: 'Camila Salazar Salazar',
            avatar: 'assets/avatares/gato_avatar.png',
          )
        ]);
    Curso c4 = Curso(
        id: '4',
        nombre: 'Curso Quinto A',
        codigoAcceso: '12345',
        departamento: 'Departamento 4',
        ciudad: 'Ciudad 4',
        colegio: 'Colegio 4',
        profesor: '4',
        portada: 'assets/fondos/FondoRegistroProfesor.png',
        estado: true,
        numEstudiantes: 10,
        descripcion:
            "Espacio para mi curso de Quinto A, donde repasaremos conceptos del pensamiento computacional",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ],
        estudiantes: [
          Estudiante(
              nombre: 'Andres Perez Perez',
              avatar: 'assets/avatares/gato_avatar.png'),
          Estudiante(
            nombre: 'Sofia González Perez',
            avatar: 'assets/avatares/gato_avatar.png',
          ),
          Estudiante(
            nombre: 'Nicolas Rodriguez Hernandez',
            avatar: 'assets/avatares/gato_avatar.png',
          ),
          Estudiante(
            nombre: 'Sergio Torres Diaz',
            avatar: 'assets/avatares/perico_avatar.png',
          ),
          Estudiante(
            nombre: 'Estefania Gutierrez Gutierrez',
            avatar: 'assets/avatares/chiguiro_avatar.png',
          ),
          Estudiante(
            nombre: 'Camila Salazar Salazar',
            avatar: 'assets/avatares/gato_avatar.png',
          )
        ]);
    Curso c5 = Curso(
        id: '5',
        nombre: 'Curso Segundo A',
        codigoAcceso: '12345',
        departamento: 'Departamento 5',
        ciudad: 'Ciudad 5',
        colegio: 'Colegio 5',
        profesor: '5',
        portada: 'assets/fondos/FondoInicio.png',
        estado: true,
        numEstudiantes: 10,
        descripcion:
            "Curso para mis niños de Segundo grado para introducirlos a conceptos del pensamiento computacional",
        fechaCreacion: '2022-01-01',
        fechaFinalizacion: '2022-01-01',
        unidades: [
          Unidad(id: '1', nombre: 'Unidad 1', estado: 'Activa', actividades: [
            Actividad(
              id: '1',
              nombre: 'Actividad 1',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '2',
              nombre: 'Actividad 2',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '3',
              nombre: 'Actividad 3',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '4',
              nombre: 'Actividad 4',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '5',
              nombre: 'Actividad 5',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ]),
          Unidad(id: '2', nombre: 'Unidad 2', estado: 'Activa', actividades: [
            Actividad(
              id: '6',
              nombre: 'Actividad 6',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '7',
              nombre: 'Actividad 7',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '8',
              nombre: 'Actividad 8',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '9',
              nombre: 'Actividad 9',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
            Actividad(
              id: '10',
              nombre: 'Actividad 10',
              estado: 'Activa',
              descripcion: '',
              tipoActividad: 'Laberinto',
            ),
          ])
        ],
        estudiantes: [
          Estudiante(
              nombre: 'Andres Perez Perez',
              avatar: 'assets/avatares/gato_avatar.png'),
          Estudiante(
            nombre: 'Sofia González Perez',
            avatar: 'assets/avatares/gato_avatar.png',
          ),
          Estudiante(
            nombre: 'Nicolas Rodriguez Hernandez',
            avatar: 'assets/avatares/chiguiro_avatar.png',
          ),
          Estudiante(
            nombre: 'Sergio Torres Diaz',
            avatar: 'assets/avatares/perico_avatar.png',
          ),
          Estudiante(
            nombre: 'Estefania Gutierrez Gutierrez',
            avatar: 'assets/avatares/gato_avatar.png',
          ),
          Estudiante(
            nombre: 'Camila Salazar Salazar',
            avatar: 'assets/avatares/gato_avatar.png',
          )
        ]);
    List<Curso> cursos = [c1, c2, c3, c4, c5];
    return Future.value(cursos);
  }

  @override
  void guardarCurso(Curso curso) {
    // TODO: implement guardarCurso
  }

  @override
  Future<Curso> getCursoById(String id) {
    // TODO: implement getCursoById
    throw UnimplementedError();
  }
}
