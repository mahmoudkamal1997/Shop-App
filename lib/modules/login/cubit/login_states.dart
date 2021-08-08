import 'package:flutter/material.dart';
import 'package:shop_app/models/login_user_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginOnLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final  ShopLoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}

class LoginShowPasswordState extends LoginStates{}