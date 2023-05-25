import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freelance/api/api_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/register_model.dart';
import '../model/user_model.dart';

class AuthController {
  ApiAuth _apiAuth = ApiAuth();

  String pesan = "";
  bool end = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();

  Future<RegisterModel> register() async {
    http.Response result = await _apiAuth.signup(
        fullNameController.text, emailController.text, passwordController.text);
    if (result.statusCode < 400) {
      Map<String, dynamic> converted = jsonDecode(result.body);
      RegisterModel<UserModel> registerModel =
          RegisterModel.fromJson(converted, UserModel.fromJson);
      return registerModel;
    } else {
      //Map<String, dynamic> converted = jsonDecode(result.body);
      RegisterModel<UserModel> registerModel = RegisterModel.errorRespons(1);
      return registerModel;
    }
    debugPrint("${result.body}");
  }
}
