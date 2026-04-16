class ContratoModel {
  final String id;
  final String nombre;
  final String puesto;
  final String curp;
  final String fechaCreacion;
  final Map<String, dynamic> datosCompletos; // Aquí guardamos todo lo demás

  ContratoModel({
    required this.id,
    required this.nombre,
    required this.puesto,
    required this.curp,
    required this.fechaCreacion,
    required this.datosCompletos,
  });

  // Este es el "Traductor": Convierte lo que viene de Firebase a un Objeto de Flutter
  factory ContratoModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ContratoModel(
      id: id,
      nombre: data['nombre'] ?? 'Sin Nombre',
      puesto: data['puesto'] ?? 'Sin Puesto',
      curp: data['curp'] ?? '',
      fechaCreacion: data['fecha_creacion'] ?? '',
      datosCompletos: data,
    );
  }
}
