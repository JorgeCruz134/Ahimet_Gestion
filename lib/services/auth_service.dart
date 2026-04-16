import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Iniciar sesión
  Future<User?> login(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } catch (e) {
      print("Error en login: $e");
      return null;
    }
  }

  // Cerrar sesión
  Future<void> logout() async => await _auth.signOut();
}
