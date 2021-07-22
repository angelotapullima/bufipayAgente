import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/theme/theme.dart';
import 'package:bufipay_agente/src/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    final responsive = Responsive.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: BufiPayColors.darkBlue,
          ),
          Positioned(
            bottom: responsive.hp(60),
            left: 0,
            right: 0,
            child: Container(height: responsive.hp(40), child: Image.asset('assets/img/BUFI_AGENTE.png') //Image.asset('assets/logo_largo.svg'),
                ),
          ),
          SafeArea(
              child: Column(
            children: [
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
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
          Positioned(
            top: responsive.hp(30),
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
                padding: EdgeInsets.only(top: responsive.hp(12), left: responsive.wp(5), right: responsive.wp(5)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _cards(responsive, Icons.payment_outlined, 'Confirmar recarga', Colors.amber),
                        Spacer(),
                        _cards(responsive, Icons.money, 'Recargar mi cuenta', Colors.amber),
                      ],
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Row(
                      children: [
                        _cards(responsive, Icons.payment_outlined, 'Ver mis movimientos', Colors.amber),
                        Spacer(),
                        _cards(responsive, Icons.person, 'Información personal', Colors.amber),
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

  Widget _cards(Responsive responsive, IconData icon, String titulo, Color color) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: responsive.hp(20),
        width: responsive.wp(40),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          //BufiPayColors.greenColor,
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
}
