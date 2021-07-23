import 'package:bufipay_agente/src/bloc/confirmar_recarga_bloc.dart';
import 'package:bufipay_agente/src/bloc/cuenta_bloc.dart';
import 'package:bufipay_agente/src/bloc/login_bloc.dart';
import 'package:bufipay_agente/src/bloc/movimientos_cuenta_bloc.dart';
import 'package:flutter/material.dart';

class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  final loginBloc = LoginBloc();
  final cuentaBloc = CuentaBloc();
  final confirmarRecargaBloc = ConfirmarRecargaBloc();
  final movimientosCuentaBloc = MovimientosCuentaBloc();

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).loginBloc;
  }

  static ConfirmarRecargaBloc confirmarRecarga(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).confirmarRecargaBloc;
  }

  static MovimientosCuentaBloc movimientosCuenta(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).movimientosCuentaBloc;
  }

  static CuentaBloc cuenta(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).cuentaBloc;
  }
}
