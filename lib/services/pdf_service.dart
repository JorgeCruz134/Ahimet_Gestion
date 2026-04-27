import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> generarContrato({
    required Map<String, String> datos,
    Uint8List? firma,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(45),
        footer: (pw.Context context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
              "Página ${context.pageNumber} de ${context.pagesCount}",
              style: const pw.TextStyle(fontSize: 7)),
        ),
        build: (pw.Context context) {
          return [
            // El contrato se mantiene intacto
            pw.Center(
              child: pw.Text("CONTRATO INDIVIDUAL DE TRABAJO",
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 15),
            _p("Contrato Individual de Trabajo que celebran por una parte AHIMET SERVICIOS CORPORATIVOS S. DE R.L. DE C.V. representada en este acto por su Administrador Único CARLOS EDUARDO RODRÍGUEZ MARTÍNEZ, a quien desde este momento y para los efectos de este contrato se le llamará \"EL PATRÓN\" y por la otra parte la C. ${(datos['nombre'] ?? '').toUpperCase()} quien desde este momento y para los efectos de este contrato se le llamará \"EL TRABAJADOR\", de conformidad con las siguientes declaraciones y cláusulas."),
            _sub("\"DECLARACIONES\""),
            _p("Declara \"EL PATRÓN\":"),
            _p("1.- Que AHIMET SERVICIOS CORPORATIVOS S. DE R.L. DE C.V. es una empresa legalmente constituida y que se encuentra representada en este acto por el DR. CARLOS EDUARDO RODRIGUEZ MARTINEZ en su carácter de Administrador Único, quien tiene la facultad para obligarlo en los términos y condiciones de este contrato."),
            _p("II.- Que desea contratar los servicios de \"EL TRABAJADOR\" para que realice las actividades relacionadas con el puesto respectivo."),
            _p("III.-Estar debidamente inscrita en el Registro Federal de Contribuyentes con la clave ASC181129AF0. IV.-Que tiene su domicilio en Paseo de Bernal #23, Paseos de San Isidro San Juan del Rio, Qro."),
            _p("Declara \"EL TRABAJADOR\":"),
            _p("I.- La C. ${(datos['nombre'] ?? '').toUpperCase()} declara ser una persona física con capacidad jurídica y natural para desarrollar el trabajo objeto de este contrato."),
            _p("II.- Llamarse como ha quedado asentado, ser de nacionalidad ${(datos['nacionalidad'] ?? '').toUpperCase()}, edad ${(datos['edad'] ?? '')} AÑOS, sexo ${(datos['sexo'] ?? '').toUpperCase()} estado civil ${(datos['estadoCivil'] ?? '').toUpperCase()}, con Clave Única de Registro de Población (CURP): ${(datos['curp'] ?? '').toUpperCase()}."),
            _p("III.-Estar debidamente inscrita en el Registro Federal de Contribuyentes (RFC) con la clave ${(datos['rfc'] ?? '').toUpperCase()} y que su domicilio es ubicado en ${(datos['direccion'] ?? '').toUpperCase()} IV.- Que tiene la calidad de ${(datos['estudios'] ?? '').toUpperCase()}, lo cual acredita con la autorización de CERTIFICADO expedida a su favor por la Secretaría de Educación Pública, por lo que posee los conocimientos necesarios para ejecutar el trabajo motivo de este contrato."),
            _p("V.- Que obtuvo y revisó toda la información que consideró necesaria para decidir y comprometerse a prestar los servicios solicitados."),
            _p("En mérito a las anteriores declaraciones, ambas partes están conformes en plasmar las condiciones generales de trabajo con base en las siguientes:"),
            _sub("\"CLÁUSULAS\""),
            _p("PRIMERA. - Para efectos de mayor brevedad se denominará en lo sucesivo a AHIMET SERVICIOS CORPORATIVOS S. DE R.L. DE C.V. como \"EL PATRÓN\"; a la C. ${(datos['nombre'] ?? '').toUpperCase()} como \"EL TRABAJADOR\"; a la Ley Federal del Trabajo como \"LA LEY\", al referirse al presente documento como \"EL CONTRATO\", y a los que suscriben como \"LAS PARTES\"."),
            _p("SEGUNDA.-\"EL CONTRATO\" se celebra por UN MES según lo establece la Ley Federal del Trabajo, toda vez que la presente contratación se origina únicamente para cubrir el puesto perentoriamente."),
            _p("TERCERA.-.- La prestación de los servicios de \"EL TRABAJADOR\" consistirán en desarrollar todas aquellas actividades relacionadas con el puesto de ${(datos['puesto'] ?? '').toUpperCase()}, para el cual se le contrata, comprendiendo entre otras las siguientes actividades: Apoyo a todas las actividades generales que se requiera dentro del área de cocina, así como atención oportuna en cada actividad y servicio que se le encomiende dentro del área del comedor para el servicio a cliente, excelente comunicación y trato con personal interno y externo de la organización."),
            _p("CUARTA.- El lugar de la prestación de los servicios de \"EL TRABAJADOR\" será en el domicilio de \"EL PATRÓN\" y/o en las instalaciones de las diversas empresas a las cuales \"EL PATRÓN\" presta servicios y/o cualquier otra que \"EL PATRON\" le indique, estando expresamente \"EL TRABAJADOR\" conforme con su rotación en estas sedes cuando lo requiera \"EL PATRÓN\" o la naturaleza de sus funciones."),
            _p("QUINTA. - La jornada de trabajo será de ${(datos['horaEntrada'] ?? '')} A ${(datos['horaSalida'] ?? '')} HRS. y los días ${(datos['diasLaborales'] ?? '').toUpperCase()} (dicha jornada será cubierta los días especificados de cada semana, mismos que podrán ser modificados de acuerdo a las necesidades del trabajo, previo aviso que se le dé a \"EL TRABAJADOR\" sobre tal circunstancia."),
            _p("SEXTA. - \"EL TRABAJADOR\" percibirá por la prestación de sus servicios como salario MENSUAL con \$${(datos['sueldoNum'] ?? '')} (${(datos['sueldoLetra'] ?? '').toUpperCase()}) MENSUAL los cuales serán cubiertos en CUATRO parcialidades ${(datos['pagoFrecuencia'] ?? '').toUpperCase()}, en moneda nacional del cuño corriente, el cual se realizará vía transferencia a la cuenta del trabajador."),
            _p("SEPTIMA.-En este acto, \"EL TRABAJADOR\" de manera libre y expresa, designa como sus beneficiarios a los que se refiere el artículo 501 de \"LA LEY\", para el pago de los salarios y prestaciones devengadas y no cobradas a su muerte o las que se generen por su fallecimiento o desaparición derivada de un acto delincuencial a los C. ${(datos['beneficiario1'] ?? '').toUpperCase()} Y C. ${(datos['beneficiario2'] ?? '').toUpperCase()} quienes tienen relación con \"EL TRABAJADOR\", dado que el primero nombrado es su ${(datos['parentesco1'] ?? '').toUpperCase()} y el segundo nombrado es su ${(datos['parentesco2'] ?? '').toUpperCase()}. Siendo el pago preferente en primer lugar a favor de C. ${(datos['beneficiario1'] ?? '').toUpperCase()} y a falta de este en segundo lugar a favor de C. ${(datos['beneficiario2'] ?? '').toUpperCase()} o a quienes sus derechos legítimos representen, previa comprobación fehaciente que hagan de su identidad y derechos."),
            _p("OCTAVA.-\"EL TRABAJADOR\" tendrá derecho por cada seis días de labores a descansar uno con el pago de salario diario correspondiente, de conformidad con \"LA LEY\" No obstante, queda establecido preferentemente como dia de descanso semanal el día DOMINGO de cada semana, pudiendo ser cambiado el mismo."),
            _p("NOVENA.- Cuando \"EL TRABAJADOR\" por razones administrativas tenga que laborar el día domingo, \"EL PATRÓN\" le pagará, además de su salario ordinario, un 25% (Veinticinco por Ciento) como prima dominical sobre el salario ordinario devengado, Independientemente del día de descanso semanal, al que tendrá derecho."),
            _p("DÉCIMA. - Quedan establecidos como días de descanso obligatorio los señalados en el artículo 74 de \"LA LEY\""),
            _p("DÉCIMA PRIMERA. - \"EL TRABAJADOR\" tendrá derecho a disfrutar de un período anual de vacaciones según lo establecido en el artículo 76 de \"LA LEY\" tomando en consideración la antigüedad en el trabajador, así como a disfrutar del salario que le corresponda. De igual modo recibirá la Prima Vacacional respectiva, equivalente al 25% del importe pagado por concepto de vacaciones."),
            _p("DÉCIMA SEGUNDA. - \"EL TRABAJADOR\" tendrá derecho a recibir por parte de \"EL PATRÓN\", antes del día 20 de diciembre de cada año, el importe correspondiente a quince (15) días de salario como pago del aguinaldo a que se refiere el artículo 87 de \"LA LEY\", o su parte proporcional por fracción de año."),
            _p("DÉCIMA TERCERA. - \"EL TRABAJADOR\" acepta someterse a los exámenes médicos que periódicamente establezca \"EL PATRÓN\" en los términos del artículo 134 Fracción X de \"LA LEY\", a fin de mantener en forma óptima sus facultades físicas e intelectuales, para el mejor desempeño de sus funciones. El médico que practique los reconocimientos será designado y retribuido por \"EL PATRÓN\"."),
            _p("DÉCIMA CUARTA. - \"EL TRABAJADOR\" acepta y por ende queda establecido que cuando por razones convenientes para \"EL PATRÓN\" éste modifique el horario de trabajo, podrá desempeñar su jornada en el que quede establecido ya que sus actividades al servicio de \"EL PATRÓN\" son prioritarias y no se contraponen a otras que pudiere llegar a desarrollar."),
            _p("DÉCIMA QUINTA. - \"EL TRABAJADOR\" deberá dar fiel cumplimiento a las disposiciones contenidas en el artículo 134 de \"LA LEY\" y que corresponden a las obligaciones de los trabajadores en el desempeño de sus labores al servicio de \"EL PATRÓN\"."),
            _p("DÉCIMA SEXTA. - \"EL TRABAJADOR\" deberá presentarse puntualmente a sus labores en el horario de trabajo establecido y firmar las listas de asistencia acostumbradas o en su caso checar su tarjeta de asistencia en el dispositivo correspondiente diariamente. En caso de retraso o falta de asistencia injustificada podrá \"EL PATRÓN\" imponerle cualquier corrección disciplinaria de las que contenga el Reglamento Interior de Trabajo o \"LA LEY\"."),
            _p("DÉCIMA SEPTIMA.- Terminada la relación laboral \"EL TRABAJADOR\" tendrá derecho al pago correspondiente de salarios y prestaciones adeudadas, vacaciones, prima vacacional y aguinaldo proporcionales en los términos que señale el artículo 47 y el artículo 53 de \"LA LEY\", en caso de que en las diversas empresas a las cuales \"EL PATRÓN\" presta servicios y/o cualquier otra que \"EL PATRON\" le indique y se dé por finalizado la prestación del servicio con acuerdo mutuo de las empresas por cualquier razón justificada \"EL TRABAJADOR\" tendrá derecho al pago de salarios y prestaciones adeudadas así como vacaciones, prima vacacional y aguinaldo proporcional, en las situaciones señaladas \"EL PATRÓN\" retendrá del importe señalado en la presente cláusula, lo relacionado con las cuotas de seguridad social, vivienda y demás que las leyes fiscales generales o especiales así señalen."),
            _sub("DECIMA OCTAVA"),
            _p("\"EL TRABAJADOR\" se obliga a no revelar ningún tipo de información propiedad del patrón, sea marcada o no como confidencial que con motivo de su trabajo llegué a tener en su poder, sea que ésta le sea dada directamente por \"EL PATRÓN\" o que le haya sido hecha a conocer indirectamente por causa de las funciones que desempeñe sin importar que directa o indirectamente tengan que ver con la naturaleza de su empleo; esta cláusula estará vigente durante toda la duración de la relación de trabajo y por un lapso de 5 años posteriores a la finalización de la misma cualquiera que sea la causa; plazo que será computado desde la fecha de terminación de la relación de trabajo referida y hasta el cumplimiento del plazo señalado."),
            _p("\"EL TRABAJADOR\" no podrá aprovechar o utilizar la información confidencial que llegue a su poder, sea del funcionamiento, manuales y operación general y/o específica de \"EL PATRÓN\" sin importar que el aprovechamiento sea para para fines propios o de terceros, extendiéndose a sus familiares, socios, consejeros, representantes legales, directivos, gerentes, asesores, dependientes y demás personas fisicas o morales, públicas o privadas que guarden relación con él sea de trabajo o no, obligándose a no referirse a la información confidencial en público ni en privado, independientemente de los fines de la exposición, ya sea cátedra, conferencia o cualquiera otra sin importar si las mismas son con fines de lucro o no."),
            _p("Respecto a la información confidencial, \"EL TRABAJADOR\" se obliga a no enajenar, arrendar, prestar, grabar, negociar, revelar, publicar, mostrar, difundir, transmitir o de alguna otra forma divulgar en todo o en parte, a cualquier persona sea fisica o moral nacional o extranjera, pública o privada, presente o futura, que no esté expresamente autorizada por escrito por \"EL PATRÓN\" por cualquier medio, aun cuando se trate de estudios, reportes, propuestas, presupuestos, u ofertas. Esta disposición es aplicable para aquellas sociedades de las cuales \"EL TRABAJADOR\" sea o pudiera llegar a ser accionista, asesor, causahabiente, apoderado, consejero, comisario, en general tenga alguna relación de cualquier índole por sí o por terceras personas, tenga ésta fin de lucro o no."),
            _p("Terminada la relación de trabajo, \"EL TRABAJADOR\" se compromete a devolver todos y cada uno de los manuales, oficios, memorándums, instructivos, formularios, balances, libros de cuentas o registros sean fisicos o electrónicos (e-mails) y cualquier otra información que directa o indirectamente haya recibido durante la relación laboral por parte de \"EL PATRÓN\" o cualquier otro agente, cliente o socio comercial de \"EL PATRÓN\", lo cual hará en un lapso no mayor a 3 días naturales quedando evidentemente prohibida la reproducción, almacenaje o distribución de dicha información para \"EL TRABAJADOR\", entendiendo que \"EL PATRÓN\" deberá darse por recibido de dicha información confidencial por escrito."),
            _p("Para el caso de incumplimiento de las disposiciones de confidencialidad por parte de \"EL TRABAJADOR\", éste se compromete a hacer pago de los daños y perjuicios que haya ocasionado a \"EL PATRÓN\" por la revelación o violación de la confidencialidad que le fue depositada incluyéndose los gastos de representación legal en que incurra por su defensa en tales circunstancias."),
            _p("DÉCIMA NÓVENA.- \"EL TRABAJADOR\" se abstendrá de ofertar, promocionar y/o ejecutar servicios idénticos, similares o conexos a aquellos proporcionados por \"EL PATRÓN\" a sus clientes o socios comerciales, por lo que \"EL TRABAJADOR\" se obliga a no ejecutar actos tendientes a la competencia desleal o ruinosa según sea el caso, obligándose también a no contratar sus servicios personales subordinados directamente con ningún cliente o socio comercial de \"EL PATRÓN\" ni durante la vigencia de su relación laboral con éste ni en un lapso de 1 año contado a partir de que su relación laboral con \"EL PATRÓN\" haya cesado, siendo responsable de dañosy perjuicios en caso de violación a este pacto, así como del pago de gastos y costas y gastos de representación legal en que \"EL PATRÓN\" incurra por la defensa de tales derechos a sus favor."),
            _p("Así mismo quedan subsistentes los pactos, obligaciones, garantías y plazos referentes a la confidencialidad que han sido detallados en la cláusula DÉCIMA OCTAVA de este instrumento."),
            _p("VIGÉSIMA. - \"EL TRABAJADOR\" otorga su consentimiento expreso para que trate y maneje sus datos personales en términos de la normatividad aplicable, por lo que \"EL PATRÓN\" es quien resguardará dicha información."),
            _p("VIGÉSIMA PRIMERA. - Para todo lo no previsto en \"EL CONTRATO\" se estará a lo prescrito por \"LA LEY\" o el Contrato Ley respectivo en su caso, así como el reglamento Interior de Trabajo."),
            _p("VIGÉSIMA SEGUNDA. - \"LAS PARTES\" reconocen como fecha de antigüedad o de iniciación de prestación de servicios de \"EL TRABAJADOR\" a partir del día ${(datos['fechaInicio'] ?? '').toUpperCase()}."),
            pw.SizedBox(height: 25),
            _firmas((datos['nombre'] ?? '').toUpperCase(),
                datos['fechaFirma'] ?? '', firma),
          ];
        },
      ),
    );

    // ✅ MODIFICACIÓN FINAL PARA IPHONE/WEB:
    // En lugar de layoutPdf, usamos sharePdf para que abra el menú nativo del dispositivo
    final bytes = await pdf.save();
    await Printing.sharePdf(
      bytes: bytes,
      filename:
          "Contrato_${(datos['nombre'] ?? 'SinNombre').replaceAll(' ', '_')}.pdf",
    );
  }

  // --- MÉTODOS DE APOYO (SIN CAMBIOS) ---
  static pw.Widget _p(String text) => pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Text(text,
          textAlign: pw.TextAlign.justify,
          style: const pw.TextStyle(fontSize: 7.5)));

  static pw.Widget _sub(String text) => pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Center(
          child: pw.Text(text,
              style:
                  pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold))));

  static pw.Widget _firmas(
          String nombre, String fechaFirma, Uint8List? firma) =>
      pw.Column(children: [
        pw.Text(
            "LEIDO QUE FUE EL PRESENTE CONTRATO POR QUIENES EN EL INTERVIENEN LO RATIFICAN E IMPUESTOS DE SU CONTENIDO LO SUSCRIBEN EN LA CIUDAD DE SAN JUAN DEL RIO, QUERÉTARO EL DÍA $fechaFirma.",
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(fontSize: 8)),
        pw.SizedBox(height: 35),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceAround, children: [
          _colFirma("DR. CARLOS EDUARDO RODRÍGUEZ MARTÍNEZ", "EL PATRÓN", null),
          _colFirma(nombre, "EL TRABAJADOR", firma),
        ]),
        pw.SizedBox(height: 25),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceAround, children: [
          _colFirma("__________________________", "TESTIGO", null),
          _colFirma("__________________________", "TESTIGO", null),
        ]),
      ]);

  static pw.Widget _colFirma(String n, String r, Uint8List? firmaImg) =>
      pw.Column(children: [
        if (firmaImg != null)
          pw.Image(pw.MemoryImage(firmaImg), height: 40)
        else
          pw.SizedBox(height: 40),
        pw.SizedBox(width: 140, child: pw.Divider()),
        pw.Text(n,
            style: pw.TextStyle(fontSize: 6.5, fontWeight: pw.FontWeight.bold)),
        pw.Text(r, style: pw.TextStyle(fontSize: 6.5)),
      ]);
}
