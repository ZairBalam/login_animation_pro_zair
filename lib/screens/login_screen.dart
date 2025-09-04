import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Cerebro de la lógica de animación
  StateMachineController? controller;

  SMIBool? isChecking; //Activar al Oso chismoso
  SMIBool? isHandsUp; //Se tapa los ojos
  SMITrigger? trigSuccess; //Se emociona
  SMITrigger? trigFail; //Se pone muy sad

  //Variable para mover los ojos:
  SMINumber? numLook;

  //Nueva bariable para controlar la visibilidad de la contrasela
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    //Para obtener el tamaño de pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            //Axis o eje vertical
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                //Ancho de la pantalla calculado por el MQ
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'animated_login_character.riv',
                  stateMachines: ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    //verificar si hay un controlador
                    if (controller == null) return;
                    //Agregar  el controlador al tablero
                    artboard.addController(controller!);
                    isChecking = controller!.findSMI('isChecking');
                    isHandsUp = controller!.findSMI('isHandsUp');
                    trigSuccess = controller!.findSMI('trigSuccess');
                    trigFail = controller!.findSMI('trigFail');

                    //Variable para mover los ojos
                    numLook = controller!.findSMI('numLook');
                  },
                ),
              ),
              //Animación
              SizedBox(height: 10),
              //Email
              TextField(
                onChanged: (value) {
                  if (isHandsUp != null) {
                    //no subir las manos al escribir email
                    isHandsUp!.change(false);
                  }

                  //verifica que este SMI no sea nulo
                  if (isChecking == null) return;
                  isChecking!.change(true);

                  if (numLook == null) return;
                  //Obtener el largo del texto
                  double lookValue = (value.length.clamp(0, 80)) * 1.5;
                  numLook!.change(lookValue);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    //Bordes Circulares
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Password
              TextField(
                onChanged: (value) {
                  if (isChecking != null) {
                    //no mover ojos al escribir eamil
                    isChecking!.change(false);
                  }
                  //verifica que este SMI no sea nulo
                  if (isHandsUp == null) return;
                  isHandsUp!.change(true);
                },
                //Para que se oculte la contraseña
                obscureText: !isPasswordVisible,

                ///Nueva propiedad
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  //Nuevo icono para mostrar u ocultar la contraseña
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    //Bordes Circulares
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: const Text(
                  "Forgot your Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              //Botón de login
              const SizedBox(height: 10),
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.blue,
                //Forma del Botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {},
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  //Centrar texto
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          //Negritas:
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
