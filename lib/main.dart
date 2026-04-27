import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // ✅ Detecta si es Web
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() async {
  // 1. Asegura que Flutter esté listo
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Conecta la App con Firebase usando lógica dual (Web/Móvil)
  if (kIsWeb) {
    // ✅ Configuración para que funcione en Vercel y iPhone (Safari)
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAgZ054dZcEnaBBQfMqtvROeh88SGbALHk",
        authDomain: "gestion-ahimet.firebaseapp.com",
        projectId: "gestion-ahimet",
        storageBucket: "gestion-ahimet.firebasestorage.app",
        messagingSenderId: "277415438277",
        appId: "1:277415438277:web:8a734cf1068bb411978dac",
      ),
    );
  } else {
    // Esto se queda igual para tu celular OPPO
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema AHIMET',
      // --- MAGIA AQUÍ ---
      theme: AppTheme.lightTheme,
      // ------------------
      home: const LoginScreen(),
    );
  }
}
