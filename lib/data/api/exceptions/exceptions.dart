

class ServiceException implements Exception {
  String cause;
  ServiceException({this.cause});
}

class AuthorizationException implements Exception {
  String cause;
  AuthorizationException({this.cause});
}

class ConnectivityException implements Exception {
  String cause;
  ConnectivityException({this.cause});
}