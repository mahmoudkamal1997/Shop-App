import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_user_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';

import 'package:shop_app/shared/network/remote/http_helper.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  ShopLoginModel RegisterModel;

  bool hidePassword = true;

  RegisterCubit(): super(RegisterInitialState());

 static RegisterCubit get (context) => BlocProvider.of(context);

 void showPassword(){
   hidePassword = ! hidePassword;
   emit(RegisterShowPasswordState());
 }

 void userRegister({
   @required String email,
   @required String password,
   @required String name,
   @required String phone,
 })
 async{
   emit(RegisterOnLoadingState());

   var response = await HttpHelper.postData(
     url :'https://student.valuxapps.com/api/register',
     data: <String, String>{
       'name': name,
       'email': email,
       'password': password,
       'phone': phone,
     },
   );

  if(response.statusCode == 200){
    print(response.body);
    RegisterModel = ShopLoginModel.fromJson(json.decode(response.body));
    //print(RegisterModel.data.email);
    emit(RegisterSuccessState(RegisterModel));
  }
  else{
    print(" server not found");
    emit(RegisterErrorState(" server not found"));
  }


 }

}