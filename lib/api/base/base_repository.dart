import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scrolling_stories/api/exceptions/exception.dart';
import 'package:scrolling_stories/constant/string_constant.dart';

enum RequestType { GET, POST, PUT, DELETE, PATCH }

class BaseRepository {
  Future<http.Response> requesthttps(
    RequestType type,
    String endpoint,
    dynamic request,
  ) async {
    Uri uri = Uri.parse(endpoint);
    http.Response response;
    switch (type) {
      case RequestType.GET:
        response = await http.get(uri);
        break;
      case RequestType.POST:
        response = await http.post(uri, body: request);
        break;
      case RequestType.PUT:
        response = await http.put(uri, body: request);
        break;
      case RequestType.PATCH:
        response = await http.patch(uri, body: request);
        break;
      case RequestType.DELETE:
        response = await http.delete(uri);
        break;
    }
    if (response.statusCode != 200) {
      defaultHandleResponse(request, response);
    }
    return response;
  }

  defaultHandleResponse(dynamic request, http.Response response) {
    if (response.statusCode >= 500) {
      throw ServerErrorException(response.body.toString());
    }
    switch (response.statusCode) {
      case 400:
        throw MissRequestException(
            getRequestJson(request), getResponseJson(response));
      case 404:
        throw NotFoundException();
      case 421:
        throw ExternalServicesFailException();
    }
  }

  String getRequestJson(dynamic request) {
    return request != null ? json.encode(request) : StringConstant.kEmpty;
  }

  String getResponseJson(http.Response response) {
    return response.body.toString();
  }
}
