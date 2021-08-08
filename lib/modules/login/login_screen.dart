import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/network/file_endpoint.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var EmailController= TextEditingController();
    var PasswordController= TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            if(state.loginModel.status)
            {
              showToast(
                message: state.loginModel.message,
                state: toastState.SUCCESS
              );
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token
              ).then((value){
                token = state.loginModel.data.token;
                NavigateToAndReplacement(context, HomeLayout());
              });

            }
            else
            {
              showToast(
                  message: state.loginModel.message,
                  state: toastState.ERROR
              );
            }
          }
        },
        builder: (context,state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN', style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black,
                      ),),
                      Text('login now to browse our hot offers', style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.grey,
                      ),),
                      SizedBox(height: 40.0,),
                      defaultTextField(
                        controller: EmailController,
                        type: TextInputType.emailAddress,
                        validate: (value){
                          if(value.isEmpty)
                            return 'Email must not be empty !';
                          return null;
                        },
                        label: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 20.0,),
                      defaultTextField(
                        controller: PasswordController,
                        type: TextInputType.visiblePassword,
                        validate: (value){
                          if(value.isEmpty)
                            return 'Password must not be empty !';
                          return null;
                        },
                        label: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: cubit.hidePassword ?Icon(Icons.visibility_off): Icon(Icons.remove_red_eye) ,
                            onPressed: (){
                              cubit.showPassword();
                            },
                        ),
                        obscureText: cubit.hidePassword
                      ),
                      SizedBox(height: 40.0,),
                      ConditionalBuilder(
                        condition: state is! LoginOnLoadingState ,
                        builder: (context) =>defaultBotton(
                          text: 'Login',
                          function: (){

                            if(formkey.currentState.validate()){
                              print(EmailController.text);
                              print(PasswordController.text);
                              LoginCubit.get(context).userLogin(
                                email: EmailController.text,
                                password: PasswordController.text
                              );
                            }
                          }
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                      ),

                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account',),
                          TextButton(
                              onPressed: (){
                                NavigateTo(context, RegisterScreen());
                              },
                              child: Text('Register Now',style: TextStyle(fontSize:18,)))
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        );}
      ),
    );
  }
}
