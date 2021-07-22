import 'dart:io';

import 'package:bufipay_agente/src/bloc/confirmar_recarga_bloc.dart';
import 'package:bufipay_agente/src/bloc/provider_bloc.dart';
import 'package:bufipay_agente/src/model/recarga_consultada_codigo_model.dart';
import 'package:bufipay_agente/src/pages/ConfirmarRecarga/alert_confirmar_recarga.dart';
import 'package:bufipay_agente/src/theme/theme.dart';
import 'package:bufipay_agente/src/utils/responsive.dart';
import 'package:bufipay_agente/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmarRecargaPage extends StatefulWidget {
  const ConfirmarRecargaPage({Key key}) : super(key: key);

  @override
  _ConfirmarRecargaPageState createState() => _ConfirmarRecargaPageState();
}

class _ConfirmarRecargaPageState extends State<ConfirmarRecargaPage> {
  TextEditingController _codigoRecargaController = TextEditingController();

  bool validateMontoRecarga = false;
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final confirmarRecargaBloc = ProviderBloc.confirmarRecarga(context);
    confirmarRecargaBloc.obtenerRecargaPorCodigoRecarga();
    return Scaffold(
      body: StreamBuilder(
          stream: confirmarRecargaBloc.recargaXCodigoStream,
          builder: (context, AsyncSnapshot<List<RecargaConsultadaPorCodigoModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return datosRecarga(responsive, confirmarRecargaBloc, snapshot.data[0]);
              } else {
                return consultaRecarga(responsive, confirmarRecargaBloc);
              }
            } else {
              return _mostrarAlert();
            }
          }),
    );
  }

  Widget consultaRecarga(Responsive responsive, ConfirmarRecargaBloc bloc) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Confirmar Recarga',
                  style: TextStyle(fontSize: responsive.ip(5), fontWeight: FontWeight.w800, color: BufiPayColors.darkBlue),
                ),
              ),
              SizedBox(
                height: responsive.hp(2),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Ingrese el código de la recarga',
                  style: TextStyle(
                    fontSize: responsive.ip(2),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                child: TextField(
                  cursorColor: Colors.black26,
                  style: TextStyle(color: Colors.black, fontSize: responsive.ip(3)),
                  keyboardType: TextInputType.number,
                  //autofocus: true,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: BufiPayColors.darkBlue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: BufiPayColors.greenColor),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: BufiPayColors.darkBlue),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: responsive.hp(1),
                        horizontal: responsive.wp(4),
                      ),
                      hintStyle: TextStyle(color: Colors.black, fontSize: responsive.ip(3)),
                      hintText: 'Código recarga'),
                  enableInteractiveSelection: false,
                  controller: _codigoRecargaController,
                ),
              ),
              SizedBox(height: responsive.hp(3)),
              Center(
                child: InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_codigoRecargaController.text.isNotEmpty) {
                      final resp = await bloc.consultar(_codigoRecargaController.text);
                      if (resp.code == '1') {
                        showToast2('Recarga Encontrada', BufiPayColors.greenColor);
                      } else if (resp.code == '3') {
                        showToast2('No existe una recarga pendiente con el código ingresado', BufiPayColors.darkBlue);
                      } else if (resp.code == '2') {
                        showToast2('Ocurrió un error, inténtalo más tarde', Colors.redAccent);
                      }
                    } else {
                      showToast2('Por favor ingrese el código de recarga', Colors.black);
                    }
                  },
                  child: Container(
                    width: responsive.wp(95),
                    height: responsive.hp(7),
                    decoration: BoxDecoration(
                      color: BufiPayColors.greenColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: BufiPayColors.darkBlue.withOpacity(0.2),
                          spreadRadius: 1.5,
                          blurRadius: 1.5,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Consultar Recarga',
                        style: TextStyle(
                          color: BufiPayColors.darkBlue,
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _cargando(context, bloc)
        ],
      ),
    );
  }

  Widget datosRecarga(Responsive responsive, ConfirmarRecargaBloc bloc, RecargaConsultadaPorCodigoModel recarga) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: BufiPayColors.darkBlue,
        ),
        Positioned(
          bottom: responsive.hp(75),
          left: 0,
          right: 0,
          child: Container(
              height: responsive.hp(18), child: SvgPicture.asset('assets/svg/AGENTE_BUFI_SIN_FONDO.svg') //Image.asset('assets/logo_largo.svg'),
              ),
        ),
        Positioned(
          top: responsive.hp(27),
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(50),
                  topStart: Radius.circular(50),
                ),
                color: BufiPayColors.whiteColor),
            child: Padding(
              padding: EdgeInsets.only(top: responsive.hp(5), left: responsive.wp(5), right: responsive.wp(5)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: responsive.ip(4),
                        backgroundColor: BufiPayColors.greenColor,
                        child: Text(
                          'R',
                          style: TextStyle(
                            color: BufiPayColors.darkBlue,
                            fontSize: responsive.ip(5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Recarga Pendiente',
                        style: TextStyle(
                          fontSize: responsive.ip(3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Código: ${recarga.codigoRecarga}',
                        style: TextStyle(
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.bold,
                          color: BufiPayColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.hp(1.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Monto',
                        style: TextStyle(fontSize: responsive.ip(2), fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('S/ ${recarga.montoRecarga}',
                          style: TextStyle(fontSize: responsive.ip(6.5), fontWeight: FontWeight.bold, color: BufiPayColors.darkBlue)),
                    ],
                  ),
                  SizedBox(
                    height: responsive.hp(4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Fecha: ${obtenerFecha(recarga.recargaFecha)}, ${obtenerHora(recarga.recargaFecha)} ',
                        style: TextStyle(
                          fontSize: responsive.ip(1.8),
                          letterSpacing: 1.2,
                          color: BufiPayColors.greenColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Expira: ${obtenerHora(recarga.fechaExpiracionRecarga)} del ${obtenerFecha(recarga.fechaExpiracionRecarga)} ',
                        style: TextStyle(
                          fontSize: responsive.ip(1.8),
                          letterSpacing: 1.2,
                          color: Colors.redAccent,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.hp(4),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            opaque: false,
                            transitionDuration: const Duration(milliseconds: 400),
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return ConfirmarRecarga(
                                idRecarga: recarga.idRecarga,
                                monto: recarga.montoRecarga,
                              );
                            },
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: responsive.wp(70),
                        height: responsive.hp(6),
                        decoration: BoxDecoration(
                          color: BufiPayColors.greenColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: BufiPayColors.darkBlue.withOpacity(0.2),
                              spreadRadius: 1.5,
                              blurRadius: 1.5,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Confirmar Recarga',
                            style: TextStyle(
                              color: BufiPayColors.darkBlue,
                              fontSize: responsive.ip(2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        bloc.obtenerRecargaPorCodigoRecarga();
                      },
                      child: Container(
                        width: responsive.wp(70),
                        height: responsive.hp(6),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: BufiPayColors.darkBlue.withOpacity(0.2),
                              spreadRadius: 1.5,
                              blurRadius: 1.5,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.ip(2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _cargando(context, bloc)
      ],
    );
  }

  Widget _mostrarAlert() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid) ? CircularProgressIndicator() : CupertinoActivityIndicator(),
      ),
    );
  }

  Widget _cargando(BuildContext context, ConfirmarRecargaBloc bloc) {
    return StreamBuilder(
      stream: bloc.cargando,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Container(
          child: snapshot.hasData
              ? (snapshot.data == true)
                  ? _mostrarAlert()
                  : null
              : null,
        );
      },
    );
  }
}
