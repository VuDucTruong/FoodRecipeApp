import 'error_handler.dart';

class Failure {
  int code; // 200 or 400
  String message; // error or success

  Failure(this.code, this.message);
  Failure.noInternet():
        code = ResponseCode.NO_INTERNET_CONNECTION,
        message = ResponseMessage.NO_INTERNET_CONNECTION;
  Failure.badRequest():
        code = ResponseCode.BAD_REQUEST,
        message = ResponseMessage.BAD_REQUEST;
  Failure.unauthorised():
        code = ResponseCode.UNAUTHORISED,
        message = ResponseMessage.UNAUTHORISED;
  Failure.notFound():
        code = ResponseCode.NOT_FOUND,
        message = ResponseMessage.NOT_FOUND;
  Failure.internalServerError():
        code = ResponseCode.INTERNAL_SERVER_ERROR,
        message = ResponseMessage.INTERNAL_SERVER_ERROR;
  Failure.connectTimeout():
        code = ResponseCode.CONNECT_TIMEOUT,
        message = ResponseMessage.CONNECT_TIMEOUT;
  Failure.dataExisted(String fieldName):
        code = ResponseCode.DEFAULT,
        message = '$fieldName existed';
  Failure.dataNotExisted(String fieldName):
        code = ResponseCode.DEFAULT,
        message = '$fieldName not existed';
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
