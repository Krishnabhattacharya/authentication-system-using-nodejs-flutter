import 'package:login_signup_node_js/controller/ApiBaseServices.dart';
import 'package:login_signup_node_js/controller/Sharedservices.dart';
import 'package:login_signup_node_js/models/loginModel.dart';

class Apiservices {
  static Future<bool> signupUser(
      {required String name,
      required String email,
      required String password}) async {
    bool isSignUp = false;
    try {
      final response =
          await ApiBaseServices.postRequest(endPoint: "/signup", body: {
        "name": name,
        "email": email,
        "password": password,
      });
      if (response.statusCode == 201) {
        isSignUp = true;
      } else {
        isSignUp = false;
      }
    } catch (e) {
      isSignUp = false;
      rethrow;
    }
    return isSignUp;
  }

  static Future<bool> LoginUser(
      {required String email, required String pass}) async {
    bool isLogin = false;
    LoginModel loginm = LoginModel();
    try {
      final response = await ApiBaseServices.loginUser(
          Exturl: "/login", email: email, password: pass);
      if (response.statusCode == 200) {
        isLogin = true;
        loginm = loginModelFromJson(response.body);
        SharedServices.setLoginDetails(loginm);
      }
    } catch (e) {
      rethrow;
    }
    return isLogin;
  }
}
