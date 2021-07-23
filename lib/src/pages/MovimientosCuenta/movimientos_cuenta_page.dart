import 'dart:io';

import 'package:bufipay_agente/src/bloc/provider_bloc.dart';
import 'package:bufipay_agente/src/model/cuenta_model.dart';
import 'package:bufipay_agente/src/model/movimientos_cuenta_model.dart';
import 'package:bufipay_agente/src/theme/theme.dart';
import 'package:bufipay_agente/src/utils/responsive.dart';
import 'package:bufipay_agente/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovimientosCuentaPage extends StatelessWidget {
  const MovimientosCuentaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final movimientosCuentaBloc = ProviderBloc.movimientosCuenta(context);
    movimientosCuentaBloc.obtenerMovimientosCuenta();
    final cuentaBloc = ProviderBloc.cuenta(context);
    cuentaBloc.obtenerDetalleCuenta();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: responsive.hp(43),
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: StreamBuilder(
                  stream: cuentaBloc.cuentaStream,
                  builder: (context, AsyncSnapshot<List<CuentaModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: responsive.wp(3),
                                ),
                                BackButton(color: BufiPayColors.darkBlue),
                                Expanded(
                                    child: Text(
                                  'Mis movimientos',
                                  style: TextStyle(color: BufiPayColors.darkBlue),
                                  textAlign: TextAlign.center,
                                )),
                                SizedBox(
                                  width: responsive.wp(10),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: responsive.hp(2),
                            ),
                            Text('Tu saldo'),
                            SizedBox(
                              height: responsive.hp(1),
                            ),
                            Text(
                              'S/${snapshot.data[0].saldo}',
                              style: TextStyle(color: BufiPayColors.darkBlue, fontSize: responsive.ip(5), fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return _mostrarAlert();
                    }
                  }),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 0.95,
            builder: (context, controller) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: BufiPayColors.darkBlue.withOpacity(0.2),
                      spreadRadius: 1.5,
                      blurRadius: 4,
                      offset: Offset(0, -2), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(5),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: responsive.hp(.5),
                          width: responsive.wp(20),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Transacciones',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Text('Ver todas', style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: movimientosCuentaBloc.movimientosCuentaStream,
                          builder: (context, AsyncSnapshot<List<MovimientosCuentaModel>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length > 0) {
                                return ListView.builder(
                                  controller: controller,
                                  padding: EdgeInsets.only(
                                    left: responsive.wp(2),
                                    right: responsive.wp(2),
                                    top: responsive.hp(2),
                                    bottom: responsive.hp(13.5),
                                  ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   PageRouteBuilder(
                                        //     opaque: false,
                                        //     transitionDuration: const Duration(
                                        //         milliseconds: 700),
                                        //     pageBuilder: (context, animation,
                                        //         secondaryAnimation) {
                                        //       return DetalleMovimientoCuenta(
                                        //         movimientoData:
                                        //             snapshot.data[index],
                                        //       );
                                        //     },
                                        //     transitionsBuilder: (context,
                                        //         animation,
                                        //         secondaryAnimation,
                                        //         child) {
                                        //       return FadeTransition(
                                        //         opacity: animation,
                                        //         child: child,
                                        //       );
                                        //     },
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: responsive.hp(.5)),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    (snapshot.data[index].tipoMovimiento == '1') ? BufiPayColors.greenColor : BufiPayColors.darkBlue,
                                                child: Text('R'),
                                              ),
                                            ),
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 9,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: responsive.wp(2),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('${snapshot.data[index].concepto}'),
                                                      Text('${obtenerFecha(snapshot.data[index].fecha)}, ${obtenerHora(snapshot.data[index].fecha)}'),
                                                    ],
                                                  ),
                                                )),
                                            Flexible(
                                                flex: 3,
                                                child: Text(
                                                  '- S/ ${snapshot.data[index].monto}',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color:
                                                          (snapshot.data[index].tipoMovimiento == '1') ? BufiPayColors.greenColor : Colors.redAccent),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text('Sin transacciones'),
                                );
                              }
                            } else {
                              return _mostrarAlert();
                            }
                          }),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _mostrarAlert() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: (Platform.isAndroid) ? CircularProgressIndicator() : CupertinoActivityIndicator(),
      ),
    );
  }
}
