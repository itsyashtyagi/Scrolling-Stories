import 'package:scrolling_stories/api/base/base_exception.dart';
import 'package:scrolling_stories/constant/string_constant.dart';

class MissRequestException extends BaseException {
  MissRequestException(String request, String response)
      : super(400, StringConstant.kSomethingIsWrong,
            request: request, response: response);
}

class NotFoundException extends BaseException {
  NotFoundException() : super(404, StringConstant.kRequestedResponseNotFound);
}

class ExternalServicesFailException extends BaseException {
  ExternalServicesFailException()
      : super(421, StringConstant.kExternalServerError);
}

class ServerErrorException extends BaseException {
  String error;

  ServerErrorException(this.error)
      : super(null, StringConstant.kServerRepliedWithError);

  @override
  String toString() {
    return StringConstant.kServerRepliedWithError;
  }
}

class NetworkException extends BaseException {
  NetworkException() : super(null, StringConstant.kNoInternetConnectionFound);
}

class ServerException extends BaseException {
  ServerException([int? code, String? message])
      : super(code, "${StringConstant.kServerError} : $message");
}
