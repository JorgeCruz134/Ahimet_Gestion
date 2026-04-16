import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() async {
  // 1. Asegura que Flutter esté listo
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Conecta la App con Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: LoginScreen(),
    );
  }
}
