import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void showToast2(String texto, Color color) {
  Fluttertoast.showToast(msg: "$texto", toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, backgroundColor: color, textColor: Colors.white);
}

obtenerFecha(String date) {
  var fecha = DateTime.parse(date);

  final DateFormat fech = new DateFormat('dd MMM yyyy', 'es');

  return fech.format(fecha);
}

obtenerHora(String date) {
  var fecha = DateTime.parse(date);

  //final DateFormat fech = new DateFormat('Hms', 'es');

  String valor = DateFormat.jms().format(fecha);

  return valor;
}

obtenerEdad(String date) {
  DateTime dob = DateTime.parse(date);
  Duration dur = DateTime.now().difference(dob);
  String differenceInYears = (dur.inDays / 365).floor().toString();
  return differenceInYears;
}

verificarNull(var data) {
  if (data != null) {
    return data.toString();
  } else {
    return '';
  }
}


// Widget mostrarAlert() {
//   return Container(
//     height: double.infinity,
//     width: double.infinity,
//     color: Colors.transparent, //Color.fromRGBO(0, 0, 0, 0.5),
//     child: Center(
//       child: Container(
//         height: 150.0,
//         child: Lottie.asset('assets/lottie/balon_futbol.json'),
//       ),
//     ),
//   );
// }
