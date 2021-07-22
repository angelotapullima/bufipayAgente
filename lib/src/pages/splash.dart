import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:after_layout/after_layout.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  @override
  void afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final preferences = Preferences();

      if (preferences.idAgente.toString().isEmpty || preferences.idAgente == null || preferences.idAgente == '0') {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'homePage');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: BufiPayColors.darkBlue,
            //child: Image(image: AssetImage('assets/img/pasto2.webp'), fit: BoxFit.cover, gaplessPlayback: true),
          ),
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   color: Colors.black.withOpacity(.5),
          // ),
          Center(
            child: Container(
              child: SvgPicture.asset(
                'assets/svg/agente_bufi.svg',
              ),
              // Image.asset(
              //   'assets/img/BUFI_AGENTE.png',
              // ),
            ),
          ),
          /*  Center(
            child: CargandoWidget(),
          ), */
        ],
      ),
    );
  }
}
