import 'package:flutter/material.dart';
import 'package:shop_app/models/login_user_model.dart';


abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterOnLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final  ShopLoginModel RegisterModel;

  RegisterSuccessState(this.RegisterModel);
}

class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterShowPasswordState extends RegisterStates{}