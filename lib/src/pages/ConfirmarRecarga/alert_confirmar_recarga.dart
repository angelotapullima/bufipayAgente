import 'dart:io';

import 'package:bufipay_agente/src/api/recargas_agente_api.dart';
import 'package:bufipay_agente/src/bloc/provider_bloc.dart';
import 'package:bufipay_agente/src/theme/theme.dart';
import 'package:bufipay_agente/src/utils/responsive.dart';
import 'package:bufipay_agente/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmarRecarga extends StatefulWidget {
  final String idRecarga;
  final String monto;
  const ConfirmarRecarga({Key key, @required this.idRecarga, @required this.monto}) : super(key: key);

  @override
  _ConfirmarRecargaState createState() => _ConfirmarRecargaState();
}

class _ConfirmarRecargaState extends State<ConfirmarRecarga> {
  ValueNotifier<bool> _cargando = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Material(
      color: Colors.black.withOpacity(.5),
      child: ValueListenableBuilder(
          valueListenable: _cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: responsive.wp(5),
                    ),
                    width: double.infinity,
                    height: responsive.hp(30),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        SizedBox(
                          height: responsive.hp(3),
                        ),
                        Container(
                          height: responsive.hp(7.5),
                          child: SvgPicture.asset(
                            'assets/svg/AGENTE_BUFI_SIN_FONDO.svg',
                          ),
                        ),
                        Container(
                          height: responsive.hp(11),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(2),
                              ),
                              child: Text(
                                '¿Está seguro que desea confirmar la Recarga por un monto de S/ ${widget.monto}?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: responsive.ip(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.green,
                        ),
                        Container(
                          height: responsive.hp(5),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  _cargando.value = true;
                                  final recargaApi = RecargaAgenteApi();
                                  final res = await recargaApi.confirmarRecarga(widget.idRecarga);

                                  if (res == 1) {
                                    showToast2('Recarga confirmada con éxito!!!', BufiPayColors.greenColor);
                                    final confirmarRecargaBloc = ProviderBloc.confirmarRecarga(context);
                                    confirmarRecargaBloc.obtenerRecargaPorCodigoRecarga();
                                    final cuentaBloc = ProviderBloc.cuenta(context);
                                    cuentaBloc.obtenerDetalleCuenta();
                                    Navigator.pop(context);
                                    //Navigator.pushReplacementNamed(context, 'homePage');
                                  } else if (res == 9) {
                                    showToast2('Saldo insuficiente', Colors.redAccent);
                                    final confirmarRecargaBloc = ProviderBloc.confirmarRecarga(context);
                                    confirmarRecargaBloc.obtenerRecargaPorCodigoRecarga();
                                    Navigator.pop(context);
                                    //Navigator.pushReplacementNamed(context, 'homePage');
                                  } else {
                                    showToast2('Ocurrió un error, intétalo más tarde', Colors.redAccent);
                                    final confirmarRecargaBloc = ProviderBloc.confirmarRecarga(context);
                                    confirmarRecargaBloc.obtenerRecargaPorCodigoRecarga();
                                    Navigator.pop(context);
                                  }
                                  _cargando.value = false;
                                  setState(() {});
                                },
                                child: Container(
                                  width: responsive.wp(43),
                                  child: Text(
                                    'Confirmar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: responsive.ip(1.8), color: BufiPayColors.darkBlue),
                                  ),
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                width: responsive.wp(.2),
                                color: Colors.green,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: responsive.wp(43),
                                  child: Text(
                                    'Cancelar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: responsive.ip(1.8), color: Colors.redAccent),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                (data)
                    ? Center(
                        child: (Platform.isAndroid) ? CircularProgressIndicator() : CupertinoActivityIndicator(),
                      )
                    : Container()
              ],
            );
          }),
    );
  }
}
