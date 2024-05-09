import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_square.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/pop_up_credenciales.dart';
import 'package:dev_tesis/utils/rutasImagenes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupUtils {
  /* PopUp para seleccionar Avatar */
  static void showAvatarSelectionPopup(BuildContext context,
      List<String> avatarPaths, Function(String) onSelectAvatar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width > 700
                ? MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width /
                    2, // Ajusta el ancho según tus necesidades
            height: MediaQuery.of(context).size.width > 700
                ? MediaQuery.of(context).size.height / 3
                : MediaQuery.of(context).size.height /
                    2, // Ajusta la altura según tus necesidades
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 70,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: avatarPaths.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          onSelectAvatar(avatarPaths[index]);
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(avatarPaths[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* PopUp para seleccionar Portada */
  static void showPortadaSelectionPopup(BuildContext context,
      List<String> portadasPaths, Function(String) onSelectPortada) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: SizedBox(
            width: 400, // Ajusta el ancho según tus necesidades
            height: 400, // Ajusta la altura según tus necesidades
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 70,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: portadasPaths.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            onSelectPortada(portadasPaths[index]);
                            Navigator.of(context).pop();
                          },
                          //card rectangular con border redondo

                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.asset(
                                  portadasPaths[index],
                                  width: 90,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              )));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* PopUp para ingresar codigo de acceso del curso */
  static void showCodeAccessPopup(BuildContext context, Curso curso) {
    final TextEditingController codigoEditingController =
        TextEditingController();
    final profesores= context.read<ProfesoresCubit>().state;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.70,
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondos/FondoHome.png'),
                fit: BoxFit.cover, // Ajuste para cubrir el contenedor
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Column(
              //centralizado

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Contenido superpuesto en la primera sección
                Column(
                  children: [
                    // Fila con botón en la parte superior derecha
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PixelSquareBttn(
                          path: 'assets/items/buttn_close.png',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: '',
                        ),
                      ],
                    ),

                    // Fila con dos secciones
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           BigText(text: '${curso.nombre}'),
                           const SizedBox(height: 30.0),
                           TitleText(text: '${profesores.firstWhere((element) => element.id == curso.profesor).nombre}'),
                           const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 30.0),
                                    const Text(
                                      "Código de acceso:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 30.0),
                                    Container(
                                      width: 300,
                                      child: TextFormField(
                                        controller: codigoEditingController,
                                        keyboardType: TextInputType.number,
                                        autofocus: true,
                                        maxLength: 4,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          hintText: "0 0 0 0",
                                          prefixIcon: Icon(Icons.code,
                                              color: blueColor),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          filled: true,
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                          fillColor: Colors.grey[300],
                                          // Aplicar validación y mensajes de error
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        // Lets apply validation
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Por favor ingrese el código de acceso";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    PixelLargeBttn(
                                      path: "assets/items/ButtonBlue.png",
                                      onPressed: () {
                                        if (codigoEditingController
                                                .text.isNotEmpty &&
                                            codigoEditingController.text ==
                                                curso.codigoAcceso) {
                                          // se cierra la ventana
                                          Navigator.of(context).pop();
                                          // se abre la ventana showCredencialesPopup
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return PopupCredenciales(
                                                  estudiantes:
                                                      curso.estudiantes!,
                                                  idCurso: curso
                                                      .id!); // Aquí debes crear una instancia del _PopupCredenciales
                                            },
                                          );
                                        } else {
                                          //toast
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Código de acceso incorrecto'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      text: 'Verificar',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* PopUp para confirmarcion de eliminacion de una actividad */
  static void showDeleteConfirmationDialog(
      BuildContext context, Function onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text("¿Estás seguro de eliminar esta actividad permanentemente?"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/avatares/perico_avatar.png',
                width: 300,
                height: 300,
              ), // Reemplaza 'ruta_de_la_imagen' con la ruta real de tu imagen
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cierra el diálogo sin realizar ninguna acción
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                onDelete(); // Llama a la función onDelete para eliminar la actividad
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }
}
