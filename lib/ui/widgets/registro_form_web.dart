import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/widgets/PopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegistroFormWeb extends StatefulWidget {
  RegistroFormWeb({Key? key}) : super(key: key);

  @override
  _RegistroFormWebState createState() => _RegistroFormWebState();
}

class _RegistroFormWebState extends State<RegistroFormWeb> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController pwdEditingController = TextEditingController();
  final TextEditingController confirmpwdEditingController =
      TextEditingController();

  String selectedAvatar =
      "assets/items/perico_mascota.png"; // Ruta del avatar predeterminado

  bool _formSubmitted = false;

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo requerido";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    Profesor profesor;
    final nombreCompleto = context.watch<NombreCompletoCubit>();
    final profesorCubit = context.watch<ProfesorCubit>();
    //arreglo con las path de los avatares
    List<String> avatars = [
      "assets/items/perico_mascota.png",
      "assets/gato.png",
      "assets/chico.png",
      "assets/chica.png",
      "assets/bus.png",
      "assets/home.png",
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "¡Únete a Mundo PC!",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Al unirte a Mundo PC, te convertirás en un pionero de la enseñanza del pensamiento computacional. Tu pasión y compromiso crearan un futuro lleno de posibilidades para nuestros estudiantes. ¡Acepta la mision!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    PopupUtils.showAvatarSelectionPopup(
                        context, avatars, _selectAvatar);
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(selectedAvatar),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Elige tu avatar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: nombreEditingController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Nombre Completo",
                    prefixIcon: Icon(Icons.person, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(nombreEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su Nombre Completo";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nombreCompleto.changeName(value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(emailEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su correo electrónico";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pwdEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    prefixIcon: Icon(Icons.lock, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(pwdEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Contraseña requerida";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: confirmpwdEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirmar Contraseña",
                    prefixIcon: Icon(Icons.lock, color: blueColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                    // Aplicar validación y mensajes de error
                    errorText: _formSubmitted
                        ? _validateField(confirmpwdEditingController.text)
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.red, // Color rojo para el borde de error
                      ),
                    ),
                  ),
                  // Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vuelva a escribir la contraseña";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: PixelLargeBttn(
                    path: "assets/items/bttn_registrar.png",
                    onPressed: () async {
                      // Marcamos el formulario como enviado
                      if (_formKey.currentState!.validate()) {
                        // Call sign in method of firebase & open home screen based on successful login
                        _formSubmitted = true;
                        profesor = Profesor(
                          id: "1",
                          nombre: nombreEditingController.text,
                          email: emailEditingController.text,
                          password: pwdEditingController.text,
                          avatar: selectedAvatar,
                        );
                        //actualizamos el estado del objeto profesor
                        profesorCubit.actualizarProfesor(profesor);
                        /* TODO:Caso de Uso crear Profesor*/
                        router.go('/crearcursobienvenida');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _selectAvatar(String avatarPath) {
    setState(() {
      selectedAvatar = avatarPath;
    });
  }
}
