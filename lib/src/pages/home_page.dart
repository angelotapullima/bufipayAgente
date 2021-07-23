import 'dart:io';

import 'package:bufipay_agente/src/bloc/provider_bloc.dart';
import 'package:bufipay_agente/src/model/cuenta_model.dart';
import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/theme/theme.dart';
import 'package:bufipay_agente/src/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    final responsive = Responsive.of(context);
    final cuentaBloc = ProviderBloc.cuenta(context);
    cuentaBloc.obtenerDetalleCuenta();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          StreamBuilder(
              stream: cuentaBloc.cuentaStream,
              builder: (context, AsyncSnapshot<List<CuentaModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return SafeArea(
                        child: Column(
                      children: [
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url2) => Container(
                                      child: Image(
                                        image: AssetImage('assets/img/loading.gif'),
                                      ),
                                    ),
                                    errorWidget: (context, url2, error) => Image(
                                      image: AssetImage('assets/img/CAPITAN_ESCUDO.png'),
                                    ),
                                    imageUrl: '${preferences.image}',
                                    imageBuilder: (context, imageProvider2) => Container(
                                      height: responsive.hp(18),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider2,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: responsive.wp(2),
                              ),
                              Text(
                                'Hola, ${preferences.personName} ${preferences.personSurname}',
                                style: TextStyle(
                                  fontSize: responsive.ip(2),
                                  fontWeight: FontWeight.w700,
                                  color: BufiPayColors.darkBlue,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  preferences.clearPreferences();
                                  Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                                },
                                child: Icon(
                                  Icons.exit_to_app,
                                  color: BufiPayColors.darkBlue,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: BufiPayColors.darkBlue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: BufiPayColors.greenColor.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: responsive.wp(5),
                          ),
                          height: responsive.hp(20),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: -170,
                                  bottom: -170,
                                  child: CircleAvatar(
                                    radius: 130,
                                    backgroundColor: BufiPayColors.greenColor,
                                  ),
                                ),
                                Positioned(
                                  right: -160,
                                  bottom: -190,
                                  child: CircleAvatar(
                                    radius: 130,
                                    backgroundColor: BufiPayColors.darkBlue.withOpacity(0.2),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: responsive.hp(1),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: responsive.wp(2),
                                        ),
                                        Container(
                                            height: responsive.hp(6),
                                            width: responsive.wp(16),
                                            child: SvgPicture.asset(
                                              'assets/svg/AGENTE_BUFI_SIN_FONDO.svg',
                                              fit: BoxFit.cover,
                                            ) //Image.asset('assets/logo_largo.svg'),
                                            ),
                                        Spacer(),
                                      ],
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'S/ ${snapshot.data[0].saldo}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.ip(3),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                                      child: Text(
                                        'Nro de Cuenta:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsive.ip(1.5),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                                      child: Text(
                                        '${snapshot.data[0].numeroCuenta}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsive.ip(1.5),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: responsive.hp(1)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
                  } else {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                    );
                  }
                } else {
                  return _mostrarAlert();
                }
              }),
          Positioned(
            top: responsive.hp(35),
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(50),
                  topStart: Radius.circular(50),
                ),
                color: BufiPayColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: BufiPayColors.darkBlue.withOpacity(0.2),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: Offset(0, -2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: responsive.hp(5), left: responsive.wp(5), right: responsive.wp(5)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: responsive.wp(5),
                        ),
                        Icon(
                          Icons.food_bank_outlined,
                          color: BufiPayColors.greenColor,
                          size: responsive.ip(5),
                        ),
                        SizedBox(
                          width: responsive.wp(5),
                        ),
                        Text(
                          '${preferences.agenteNombre}',
                          style: TextStyle(fontSize: responsive.ip(4)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    Row(
                      children: [
                        _cards(context, responsive, Icons.payment_outlined, 'Confirmar recarga', BufiPayColors.greenColor, 'confirmarRecarga'),
                        Spacer(),
                        _cards(context, responsive, Icons.money, 'Recargar mi cuenta', BufiPayColors.greenColor, 'recargarCuenta'),
                      ],
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Row(
                      children: [
                        _cards(context, responsive, Icons.payment_outlined, 'Ver mis movimientos', BufiPayColors.greenColor, 'movimientos'),
                        Spacer(),
                        _cards(context, responsive, Icons.person, 'Información cuenta', BufiPayColors.greenColor, 'infoCuenta'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cards(BuildContext context, Responsive responsive, IconData icon, String titulo, Color color, String page) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, page);
      },
      child: Container(
        height: responsive.hp(20),
        width: responsive.wp(40),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 1.5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: responsive.hp(2), horizontal: responsive.wp(3)),
          child: Column(
            children: [
              SizedBox(
                height: responsive.hp(1),
              ),
              Icon(
                icon,
                color: BufiPayColors.darkBlue,
                size: responsive.ip(5),
              ),
              SizedBox(
                height: responsive.hp(1),
              ),
              Text(titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: BufiPayColors.darkBlue,
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
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
}

class LightColor {
  static const Color background = Color(0XFFFFFFFF);

  static const Color titleTextColor = const Color(0xff1d2635);
  static const Color subTitleTextColor = const Color(0xff797878);

  static const Color lightBlue1 = Color(0xff375efd);
  static const Color lightBlue2 = Color(0xff3554d3);
  static const Color navyBlue1 = Color(0xff15294a);
  static const Color lightNavyBlue = Color(0xff6d7f99);
  static const Color navyBlue2 = Color(0xff2c405b);
  static const Color navyBlue3 = Color(0xFF031731);

  static const Color yellow = Color(0xfffbbd5c);
  static const Color yellow2 = Color(0xffe7ad03);

  static const Color lightGrey = Color(0xfff1f1f3);
  static const Color grey = Color(0xffb9b9b9);
  static const Color darkgrey = Color(0xff625f6a);

  static const Color black = Color(0xff040405);
  static const Color lightblack = Color(0xff3E404D);
}
