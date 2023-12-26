import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_signup_node_js/controller/Sharedservices.dart';

class ApiBaseServices {
  static String baseURL = "http://10.0.2.2:3000";
  static Uri url({required String extendedURL}) {
    return Uri.parse("$baseURL$extendedURL");
  }

//for login and get all data//----------------------------------------------------------
  static Future<http.Response> loginUser({
    required String Exturl,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      url(extendedURL: Exturl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }

//http get function//-------------------------------------------------------------------------------
  static Future<http.Response> getRequest({
    required String endPoint,
  }) async {
    final response = await http.get(
      url(extendedURL: endPoint),
    );
    return response;
  }

  //get requestwith headers
  static Future<http.Response> getRequestWithHeaders({
    required String endPoint,
  }) async {
    Map<String, String> newHeaders = {};
    Map<String, String> conentType = {'Content-Type': 'application/json'};
    newHeaders.addAll(conentType);
    if (SharedServices.isLoggedIn()) {
      newHeaders.addAll({'Authorization': SharedServices.userAuth()});
    }
    print("newheaders$newHeaders");
    final response = await http.get(
      url(extendedURL: endPoint),
      headers: newHeaders,
    );
    return response;
  }

//http post function//-----------------------------------------------------------------------------------
  static Future<http.Response> postRequest({
    required String endPoint,
    required Object body,
  }) async {
    final response = await http.post(
      url(extendedURL: endPoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }

//   //http update function//-----------------------------------------------------------------------------
  static Future<dynamic> updateRequest({
    required String endPoint,
    required Object body,
  }) async {
    final response = await http.put(
      url(extendedURL: endPoint),
      body: jsonEncode(body),
    );
    return response;
  }

//   //http delete function//-----------------------------------------------------------------------------
  static Future<dynamic> deleteRequest({
    required String endPoint,
  }) async {
    final response = await http.delete(
      url(extendedURL: endPoint),
      // headers: _getHeaders(),
    );
    return response;
  }
}
