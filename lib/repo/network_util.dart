import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';

import 'error.dart';

// A Singleton class
class NetworkUtil {
  // Creating singleton object.
  static NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Future<ParsedResponse> get(String url, {Map<String, String>? headers, Map<String, dynamic>? params}) {
    url += encodeUrl(params);

    print("URL : $url Headers $headers");
    Uri uri = Uri.parse(url);
    return http.get(uri, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code for " + url + "::: " + statusCode.toString());
      print("Response ::: " + res);

      if (res == null || res.isEmpty) {
        throw NHSError(ErrorCodes.SERVER_ERROR, "Server returned an empty response");
      } else {
        return ParsedResponse(statusCode, res);
      }
    }).catchError((Object e) {
      throw NHSError(ErrorCodes.NO_INTERNET, "Unable to reach server at the moment");
    });
  }

  Future<ParsedResponse> post(String url, {Map<String, String>? headers, body, params, encoding}) {
    url += encodeUrl(params);
    print("Request ::: $url\nBody ::: $body\nHeaders ::: $headers");
    return http.post(Uri.parse(url), body: body, headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code for " + url + "::: " + statusCode.toString());
      print("Response ::: " + res);

      if (res == null || res.isEmpty) {
        throw NHSError(ErrorCodes.SERVER_ERROR, "Server returned an empty response");
      } else {
        return ParsedResponse(statusCode, res);
      }
    }).catchError((Object e) {
      throw NHSError(ErrorCodes.NO_INTERNET, "Unable to reach server at the moment");
    });
  }

  Future<ParsedResponse> put(String url, {Map<String, String>? headers, body, encoding}) {
    return http.put(Uri.parse(url), body: body, headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code for " + url + "::: " + statusCode.toString());
      print("Response ::: " + res);

      if (res.isEmpty) {
        throw NHSError(ErrorCodes.SERVER_ERROR, "Server returned an empty response");
      } else {
        return ParsedResponse(statusCode, res);
      }
    }).catchError((Object e) {
      throw NHSError(ErrorCodes.NO_INTERNET, "Unable to reach server at the moment");
    });
  }

  Future<ParsedResponse> delete(String url, {Map<String, String>? headers}) {
    return http.delete(Uri.parse(url), headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code for " + url + "::: " + statusCode.toString());
      print("Response ::: " + res);

      if (res.isEmpty) {
        throw NHSError(ErrorCodes.SERVER_ERROR, "Server returned an empty response");
      } else {
        return ParsedResponse(statusCode, res);
      }
    }).catchError((Object e) {
      throw NHSError(ErrorCodes.NO_INTERNET, "Unable to reach server at the moment");
    });
  }


  Future<bool> isConnectionAvailable() async {
    bool connected = false;
    try {
      connected = await InternetAddress.lookup('https://www.google.com').then((value) {
        if (value.isNotEmpty && value[0].rawAddress.isNotEmpty) {
          print('connected');
          return true;
        }
        return false;
      });
    } on SocketException catch (_) {
      print('not connected');
      connected = false;
    }

    return connected;
  }

  String encodeUrl(Map<String, dynamic>? parameters) {
    if (parameters == null) {
      return "";
    }

    String paramsString = "";
    bool first = true;

    for (String key in parameters.keys) {
      if (first) {
        first = false;
        paramsString += "?";
      } else {
        paramsString += "&";
      }
      paramsString += key + "=" + parameters[key].toString();
    }
    return paramsString;
  }

  static List<int> decode(String hex) {
    //List(he.length ~/ 2) cant be used as it is deprecated, so used List.filled
    List<int> bytes = List.filled(hex.length ~/ 2, 0, growable: true);
    for (int i = 0; i < bytes.length; i++) {
      bytes[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return bytes;
  }

  static String encode(List<int> b1) {
    var buffer = StringBuffer();
    for (int i = 0; i < b1.length; i++) {
      int v = b1[i] & 0xff;
      buffer.write(sprintf("%02X", [v]));
    }
    return buffer.toString();
  }
}

class ParsedResponse {
  int statusCode;
  String response;

  ParsedResponse(this.statusCode, this.response);

  bool isOk() {
    return statusCode == 200;
  }
}
