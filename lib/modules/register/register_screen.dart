import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/network/file_endpoint.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var emailController= TextEditingController();
    var passwordController= TextEditingController();
    var nameController= TextEditingController();
    var phoneController= TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state){
            if(state is RegisterSuccessState){
              if(state.RegisterModel.status)
              {
                showToast(
                    message: state.RegisterModel.message,
                    state: toastState.SUCCESS
                );
                CacheHelper.saveData(
                    key: 'token',
                    value: state.RegisterModel.data.token
                ).then((value){
                  token = state.RegisterModel.data.token;
                  NavigateToAndReplacement(context, HomeLayout());
                });

              }
              else
              {
                showToast(
                    message: state.RegisterModel.message,
                    state: toastState.ERROR
                );
              }
            }
          },
          builder: (context,state) {
            RegisterCubit cubit = RegisterCubit.get(context);
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
                          Text('Register', style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),),
                          Text('Register now to browse our hot offers', style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.grey,
                          ),),
                          SizedBox(height: 40.0,),
                          defaultTextField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value.isEmpty)
                                return 'name must not be empty !';
                              return null;
                            },
                            label: 'Full Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          SizedBox(height: 20.0,),
                          defaultTextField(
                            controller: emailController,
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
                              controller: passwordController,
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
                          SizedBox(height: 20.0,),
                          defaultTextField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value){
                              if(value.isEmpty)
                                return 'Mobile Number must not be empty !';
                              return null;
                            },
                            label: 'Mobile Number',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          SizedBox(height: 20.0,),
                          SizedBox(height: 40.0,),
                          ConditionalBuilder(
                            condition: state is! RegisterOnLoadingState ,
                            builder: (context) =>defaultBotton(
                                text: 'Register',
                                function: (){
                                  if(formkey.currentState.validate()){
                                    print(emailController.text);
                                    print(passwordController.text);
                                    RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                }
                            ),
                            fallback: (context)=>Center(child: CircularProgressIndicator(),),
                          ),

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

