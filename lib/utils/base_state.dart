import 'package:equatable/equatable.dart';
import 'package:meshi/data/api/exceptions/exceptions.dart';
import 'package:path/path.dart';

import 'localiztions.dart';

abstract class BaseState extends Equatable {
  BaseState({List props}): super(props);
}

class InitialState<T> extends BaseState {
  T initialData;
  InitialState({this.initialData}): super(props: [initialData]);
  @override
  String toString() => 'state-initial';
}

class LoadingState extends BaseState {
  @override
  String toString() => 'state-loading';
}

class PerformingRequestState extends BaseState {
  @override
  String toString() => 'state-performing-request';
}

class SuccessState<T> extends BaseState {
  T data;

  SuccessState({this.data}): super(props: [data]);

  @override
  String toString() => 'state-success';
}

class ErrorState extends BaseState {
  String get msg {
    if (exception is AuthorizationException) {
      return
        "Error al verificar autenticacion.";
    }
    if (exception is ConnectivityException) {
      return "No se pudo establecer la conexion.";
    }

    return "Ocurrio un error, por favor intentalo mas tarde.";
  }

  Exception exception;

  ErrorState({this.exception});

  @override
  String toString() => 'state-error';
}
