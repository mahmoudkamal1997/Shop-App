import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';

Widget defaultTextField({controller,type,validate,onSubmit,label,prefixIcon= null,suffixIcon= null,obscureText= false,}){
  return TextFormField(
    controller: controller,
    keyboardType: type ,
    validator: validate,
    onFieldSubmitted: onSubmit,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    ),
  );
}

Widget defaultBotton({@required text,@required function,}){
  return  Container(
    width: double.infinity,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.blue,
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text('$text',style: TextStyle(fontSize:20,color: Colors.white,)),
    ),
  );
}

void NavigateTo(context, screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void NavigateToAndReplacement(context, screen){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
}

void showToast({@required String message,@required toastState state}){

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum toastState{SUCCESS,ERROR,WARNING}

Color chooseToastColor(toastState state){

  Color color;

  switch(state){

    case toastState.SUCCESS:
      color = Colors.green;
      break;

    case toastState.ERROR:
      color = Colors.red;
      break;

    case toastState.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;

}



Widget defaultProfileTextField({controller,type,validate,hint,suffixIcon= null,prefixIcon= null, alignment =TextAlign.start , obscureText= false,}){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
    ),
    child: TextFormField(
      textAlign: alignment ,
      controller: controller ,
      obscureText: obscureText,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        prefix: prefixIcon,
        suffixIcon: suffixIcon,


      ),
    ),
  );
}

void singOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      NavigateToAndReplacement(context,LoginScreen());
    }
  });
}