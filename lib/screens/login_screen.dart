import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'formulario_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> _intentarLogin() async {
    if (_emailController.text.isNotEmpty && _passController.text.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        );

        if (!mounted) return;
        Navigator.pop(context); // Quita el círculo de carga
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FormularioScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        Navigator.pop(context);

        String mensaje = "Error de acceso";
        if (e.code == 'user-not-found') mensaje = "Usuario no registrado";
        if (e.code == 'wrong-password') mensaje = "Contraseña incorrecta";

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(mensaje)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, llena todos los campos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ CORREGIDO: Usamos Image.asset y el nombre logo_ahimet1.png
                Image.asset(
                  'assets/logo_ahimet1.png',
                  height: 140,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.business_center,
                      size: 100,
                      color: Color(0xFF0A1931)),
                ),
                const SizedBox(height: 15),
                const Text(
                  "SISTEMA DE GESTIÓN AHIMET",
                  style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(height: 50),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Correo Electrónico",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: _intentarLogin,
                  child: const Text("INICIAR SESIÓN"),
                ),

                const SizedBox(height: 30),
                const Text(
                  "Servicios Corporativos S de RL de CV",
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
