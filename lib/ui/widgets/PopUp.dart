import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_square.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/pop_up_credenciales.dart';
import 'package:dev_tesis/utils/rutasImagenes.dart';
import 'package:flutter/material.dart';

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
            width: 300, // Ajusta el ancho según tus necesidades
            height: 300, // Ajusta la altura según tus necesidades
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
                            onPressed: () {},
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
                          const BigText(text: 'Curso C'),
                          const SizedBox(height: 30.0),
                          const TitleText(text: 'Profesor: Angela Muñoz'),
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
                                    SizedBox(height: 30.0),
                                    Container(
                                      width: 300,
                                      child: TextFormField(
                                        controller: codigoEditingController,
                                        keyboardType: TextInputType.number,
                                        autofocus: false,
                                        maxLength: 4,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          hintText: "0 0 0 0",
                                          prefixIcon:
                                              Icon(Icons.code, color: blueColor),
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

  // PopUp para ingresar credenciales de usuario
  static void showCredencialesPopup(
      BuildContext context, List<Estudiante> estudiantes) {
    List<String> avatarPaths = RutasImagenes.getRutasAvatares();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.70,
            height: MediaQuery.of(context).size.height * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // TabBar para "Solo Yo" y "En Equipo"
                TabBar(
                  tabs: [
                    Tab(text: 'Solo Yo'),
                    Tab(text: 'En Equipo'),
                  ],
                ),
                // TabBarView para contenido de los tabs
                Expanded(
                  child: TabBarView(
                    children: [
                      // Contenido del tab "Solo Yo"
                      _buildTabContent(estudiantes),
                      // Contenido del tab "En Equipo"
                      _buildTabContent(estudiantes),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Fila con el botón de siguiente
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   PixelLargeBttn(
                        path: "assets/items/ButtonBlue.png",
                        onPressed: () {},
                        text: 'Ingresar',
                      ),
                    
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static _buildTabContent(List<Estudiante> estudiantes) {
    List<String> avatarPaths = RutasImagenes.getRutasAvatares();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna de nombres
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: estudiantes.map((estudiante) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      estudiante.nombre,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(width: 16),
        // Columna de avatares en tres columnas
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 90,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: avatarPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  /* onSelectAvatar(avatarPaths[index]);
                    Navigator.of(context).pop(); */
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
    );
  }
}
