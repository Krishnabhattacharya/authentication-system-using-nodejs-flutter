import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_signup_node_js/controller/Preferences.dart';
import 'package:login_signup_node_js/models/loginModel.dart';

//**************************************************************************** *//
//EMPORTANT                 //EMPORTANT                    //EMPORTANT

//%%%%%%%%%%%$$$$$$$$$$$$$###############@@@@@@@@@@@@@@@@@@@@@@@@@

//write this two line in main function

//------>>>     WidgetsFlutterBinding.ensureInitialized();
//---->>>     preferences = await SharedPreferences.getInstance();

//%%%%%%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$$$########################

class SharedServices {
  //get user Auth
  static String userAuth() {
    var model = LoginModel.fromJson(
        jsonDecode(preferences!.getString("login_details")!));
    return "Bearer ${model.token!}";
  }

//set all the login details-----------------------------------
  static Future<void> setLoginDetails(LoginModel? usermodel) async {
    if (usermodel != null) {
      preferences!.setString("login_details", jsonEncode(usermodel.toJson()));
    }
  }

// get the login details------------------------------------
  static LoginModel? getLoginDetails() {
    String? jsonDetails = preferences!.getString("login_details");
    if (jsonDetails != null) {
      return LoginModel.fromJson(jsonDecode(jsonDetails));
    }
    return null;
  }

//for login check//----------------------------------------
  static bool isLoggedIn() {
    return preferences!.getString("login_details") != null ? true : false;
  }

//for logout//--------------------------------------------
  static Future<bool> logout(BuildContext context) async {
    await preferences!.clear();
    return true;
  }
}
