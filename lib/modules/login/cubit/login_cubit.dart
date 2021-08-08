import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_user_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/remote/http_helper.dart';


class LoginCubit extends Cubit<LoginStates>{
  ShopLoginModel loginModel;

  bool hidePassword = true;

  LoginCubit(): super(LoginInitialState());

 static LoginCubit get (context) => BlocProvider.of(context);

 void showPassword(){
   hidePassword = ! hidePassword;
   emit(LoginShowPasswordState());
 }

 void userLogin({
   @required String email,
   @required String password,
 })
 async{
   emit(LoginOnLoadingState());

   var response = await HttpHelper.postData(
     url :'https://student.valuxapps.com/api/login',
     data: <String, String>{
       'email': email,
       'password': password,
     },
   );

  if(response.statusCode == 200){
    print(response.body);
    loginModel = ShopLoginModel.fromJson(json.decode(response.body));
    //print(loginModel.data.email);
    emit(LoginSuccessState(loginModel));
  }
  else{
    print(" server not found");
    emit(LoginErrorState(" server not found"));
  }
 /*then((value){
     print(value.body);
     loginModel = ShopLoginModel.fromJson(json.decode(value.body));

     print(loginModel.data.email);
     emit(LoginSuccessState());
   }).catchError((error) {
     print(error.toString());
     emit(LoginErrorState(error.toString()));
   });*/

 }

}