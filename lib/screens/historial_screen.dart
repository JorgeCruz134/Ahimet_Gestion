import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/pdf_service.dart';
import '../models/contrato_model.dart'; // <--- Importamos tu nuevo modelo

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color azulAhimet = const Color(0xFF0D47A1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Contratos"),
        backgroundColor: azulAhimet,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder(
        // Escucha la base de datos en tiempo real
        stream: FirebaseFirestore.instance
            .collection('contratos')
            .orderBy('fecha_creacion', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return const Center(child: Text("Error al cargar"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text("No hay contratos registrados aún"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              // --- AQUÍ USAMOS EL MODELO ---
              // Convertimos la data de Firebase al molde de ContratoModel
              final contrato = ContratoModel.fromFirestore(doc.id, data);

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: azulAhimet,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    contrato.nombre
                        .toUpperCase(), // Usamos la propiedad del modelo
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Puesto: ${contrato.puesto}\nFecha: ${contrato.fechaCreacion.split('T')[0]}",
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.file_download, color: Colors.green),
                    onPressed: () async {
                      // RE-GENERAR PDF usando los datos guardados en el modelo
                      Map<String, String> datosParaPdf = contrato.datosCompletos
                          .map((key, value) => MapEntry(key, value.toString()));

                      await PdfService.generarContrato(datos: datosParaPdf);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
