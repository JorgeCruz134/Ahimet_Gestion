import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import '../services/pdf_service.dart';
import 'historial_screen.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // --- CONTROLADORES COMPLETOS ---
  final _nombre = TextEditingController();
  final _nacionalidad = TextEditingController();
  final _edad = TextEditingController();
  final _sexo = TextEditingController();
  final _estadoCivil = TextEditingController();
  final _curp = TextEditingController();
  final _rfc = TextEditingController();
  final _nss = TextEditingController();
  final _direccion = TextEditingController();
  final _estudios = TextEditingController();

  final _puesto = TextEditingController();
  final _sueldoNum = TextEditingController();
  final _sueldoLetra = TextEditingController();
  final _pagoFrecuencia = TextEditingController();
  final _horaEntrada = TextEditingController();
  final _horaSalida = TextEditingController();
  final _diasLaborales = TextEditingController();
  final _fechaInicio = TextEditingController();
  final _fechaFirma = TextEditingController();

  final _beneficiario1 = TextEditingController();
  final _parentesco1 = TextEditingController();
  final _beneficiario2 = TextEditingController();
  final _parentesco2 = TextEditingController();

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<void> _guardarYGenerar() async {
    Uint8List? firmaBytes;
    if (_signatureController.isNotEmpty) {
      firmaBytes = await _signatureController.toPngBytes();
    }

    Map<String, String> datosContrato = {
      'nombre': _nombre.text,
      'nacionalidad': _nacionalidad.text,
      'edad': _edad.text,
      'sexo': _sexo.text,
      'estadoCivil': _estadoCivil.text,
      'curp': _curp.text,
      'rfc': _rfc.text,
      'nss': _nss.text,
      'direccion': _direccion.text,
      'estudios': _estudios.text,
      'puesto': _puesto.text,
      'sueldoNum': _sueldoNum.text,
      'sueldoLetra': _sueldoLetra.text,
      'pagoFrecuencia': _pagoFrecuencia.text,
      'horaEntrada': _horaEntrada.text,
      'horaSalida': _horaSalida.text,
      'diasLaborales': _diasLaborales.text,
      'fechaInicio': _fechaInicio.text,
      'fechaFirma': _fechaFirma.text.isEmpty
          ? DateTime.now().toString().split(' ')[0]
          : _fechaFirma.text,
      'beneficiario1': _beneficiario1.text,
      'parentesco1': _parentesco1.text,
      'beneficiario2': _beneficiario2.text,
      'parentesco2': _parentesco2.text,
      'fecha_creacion': DateTime.now().toIso8601String(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('contratos')
          .add(datosContrato);
      await PdfService.generarContrato(datos: datosContrato, firma: firmaBytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Contrato guardado y PDF generado con éxito")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error al procesar: $e")));
      }
    }
  }

  Widget _buildStepBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _stepCircle(0, "Personal"),
          _stepLine(0),
          _stepCircle(1, "Laboral"),
          _stepLine(1),
          _stepCircle(2, "Firma"),
        ],
      ),
    );
  }

  Widget _stepCircle(int index, String label) {
    bool isCompleted = _currentStep > index;
    bool isActive = _currentStep == index;
    Color colorPrincipal = const Color(0xFF0A1931);

    return Column(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: isActive
                ? colorPrincipal
                : (isCompleted ? Colors.green.shade100 : Colors.white),
            shape: BoxShape.circle,
            border: Border.all(
                color: isCompleted ? Colors.green : colorPrincipal, width: 2),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 20, color: Colors.green)
                : Text("${index + 1}",
                    style: TextStyle(
                        color: isActive ? Colors.white : colorPrincipal,
                        fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _stepLine(int index) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        color: _currentStep > index
            ? Colors.green
            : const Color(0xFF0A1931).withOpacity(0.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AHIMET - REGISTRO"), centerTitle: true),
      body: Column(
        children: [
          _buildStepBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Form(key: _formKey, child: _buildCurrentPage()),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildCurrentPage() {
    if (_currentStep == 0) return _pagePersonal();
    if (_currentStep == 1) return _pageLaboral();
    return _pageFirma();
  }

  Widget _pagePersonal() => Column(
        children: [
          // ✅ CORREGIDO: Cambio de Image.network a Image.asset con ruta completa
          Image.asset(
            'assets/logo_ahimet1.png',
            height: 80,
            errorBuilder: (c, e, s) =>
                const Icon(Icons.business, size: 50, color: Color(0xFF0A1931)),
          ),
          const SizedBox(height: 20),
          _input(_nombre, "Nombre Completo"),
          Row(children: [
            Expanded(child: _input(_nacionalidad, "Nacionalidad")),
            const SizedBox(width: 10),
            Expanded(child: _input(_edad, "Edad", tipo: TextInputType.number)),
          ]),
          Row(children: [
            Expanded(child: _input(_sexo, "Sexo")),
            const SizedBox(width: 10),
            Expanded(child: _input(_estadoCivil, "Estado Civil")),
          ]),
          Row(children: [
            Expanded(child: _input(_curp, "CURP")),
            const SizedBox(width: 10),
            Expanded(child: _input(_rfc, "RFC")),
          ]),
          _input(_nss, "Número de Seguro Social (NSS)"),
          _input(_direccion, "Dirección Completa"),
          _input(_estudios, "Escolaridad (Ej: Licenciatura)"),
        ],
      );

  Widget _pageLaboral() => Column(
        children: [
          _input(_puesto, "Puesto"),
          Row(children: [
            Expanded(
                child: _input(_sueldoNum, "Sueldo \$",
                    tipo: TextInputType.number)),
            const SizedBox(width: 10),
            Expanded(child: _input(_pagoFrecuencia, "Frecuencia de Pago")),
          ]),
          _input(_sueldoLetra, "Sueldo en Letra"),
          Row(children: [
            Expanded(child: _input(_horaEntrada, "Hora Entrada")),
            const SizedBox(width: 10),
            Expanded(child: _input(_horaSalida, "Hora Salida")),
          ]),
          _input(_diasLaborales, "Días Laborales (Ej: Lunes a Sábado)"),
          _input(_fechaInicio, "Fecha de Inicio (Ej: 09 de Abril 2026)"),
          _input(_fechaFirma, "Fecha de Firma (Ej: 09 de Abril 2026)"),
        ],
      );

  Widget _pageFirma() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _input(_beneficiario1, "Nombre Beneficiario 1"),
          _input(_parentesco1, "Parentesco B1"),
          const SizedBox(height: 10),
          _input(_beneficiario2, "Nombre Beneficiario 2"),
          _input(_parentesco2, "Parentesco B2"),
          const Divider(height: 40),
          const Text("Firma del Trabajador:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8)),
            child: Signature(
                controller: _signatureController,
                height: 150,
                backgroundColor: Colors.white),
          ),
          Center(
              child: TextButton(
                  onPressed: () => _signatureController.clear(),
                  child: const Text("LIMPIAR FIRMA"))),
        ],
      );

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
                child: OutlinedButton(
                    onPressed: () => setState(() => _currentStep--),
                    child: const Text("ATRÁS"))),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  _guardarYGenerar();
                }
              },
              child:
                  Text(_currentStep == 2 ? "FINALIZAR Y GENERAR" : "SIGUIENTE"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(TextEditingController cont, String lab,
          {int maxLines = 1, TextInputType tipo = TextInputType.text}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
            controller: cont,
            maxLines: maxLines,
            keyboardType: tipo,
            decoration: InputDecoration(labelText: lab)),
      );
}
