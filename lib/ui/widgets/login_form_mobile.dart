import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginFormMobile extends StatelessWidget {
  LoginFormMobile({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController pwdEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "¡Bienvenido a Mundo PC!",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Ingresa y que el aprendizaje continue.\nInnovació́n, creatividad y enseñanza.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              key: _formKey,
              child: Column(children: [
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
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  //Lets apply validation
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
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.grey[300]),
                  //Lets apply validation
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          //Open Forgot password screen here
                          //
                          print("Olvidaste tu contraseña");
                        },
                        child: const Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: PixelLargeBttn(
                        path: "assets/items/ButtonBlue.png",
                        onPressed: () async {
                          /*
                      if (_formKey.currentState!.validate()) {
                        AuthenticationService()
                            .signUpWithEmail(
                                name: 'admin',
                                email: emailEditingController.text,
                                password: pwdEditingController.text)
                            .then((authResponse) {
                          if (authResponse.authStatus == AuthStatus.success) {
                            Fluttertoast.showToast(
                              msg: 'Usuario registrado',
                              toastLength: Toast
                                  .LENGTH_SHORT, // Duración corta del mensaje
                              gravity: ToastGravity
                                  .BOTTOM, // Posición del mensaje en la pantalla
                              backgroundColor: Colors
                                  .grey[700], // Color de fondo del mensaje
                              textColor:
                                  Colors.white, // Color del texto del mensaje
                            ).then((value) => {
                                  SedeService.guardarEnFirestoreUsuario(
                                      'admin', emailEditingController.text)
                                });
                          } else {
                            //In case error we will show error message using snackbar.
                            //For that lets write utility class which has functions to show
                            //error & success messages
                            Util.showErrorMessage(
                                context, authResponse.message);
                          }
                        });
                      }*/

                          if (_formKey.currentState!.validate()) {
                            //Call sign in method of firebase & open home screen based on successfull login
                          }
                        },
                        text: 'Ingresar')),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿Aún no tienes una cuenta?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        //Open Forgot password screen here
                        //
                        router.go('/registroprofesor');
                      },
                      child: const Text(
                        "Registrarse",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ])),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
