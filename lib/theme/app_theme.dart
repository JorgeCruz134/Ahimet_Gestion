import 'package:flutter/material.dart';

class AppTheme {
  // Colores Oficiales AHIMET
  static const Color azulCorporativo = Color(0xFF0A1931);
  static const Color grisFondoOficina = Color(0xFFF0F2F5);
  static const Color blancoPuro = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: azulCorporativo,
      scaffoldBackgroundColor: grisFondoOficina,

      // Estilo de los Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: blancoPuro,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        labelStyle: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: azulCorporativo, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Estilo de los Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: azulCorporativo,
          foregroundColor: blancoPuro,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          textStyle:
              const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),

      // Estilo de la AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: azulCorporativo,
        foregroundColor: blancoPuro,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),

      // Estilo de las Tarjetas (Historial)
      cardTheme: CardThemeData(
        color: blancoPuro,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ); // Aquí cierra el ThemeData
  }
}
