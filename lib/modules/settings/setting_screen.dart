import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/login_user_model.dart';
import 'package:shop_app/shared/components/components.dart';


class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  final picker= ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessUpdateUserDataState) {
          if (state.model.status) {
            showToast(
                message: state.model.message,
                state: toastState.SUCCESS
            );
          }
          else {
            showToast(
                message: state.model.message,
                state: toastState.ERROR
            );
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return  cubit.userModel != null ? buildSettingScren(context, cubit.userModel,state) : Center(child: CircularProgressIndicator(),);

      }

    );
  }


  Widget buildSettingScren(context, ShopLoginModel model,state){
    nameController.text = model.data.name;
    emailController.text = model.data.email;
    phoneController.text = model.data.phone;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if(state is ShopOnLoadingUpdateUserDataState)
              LinearProgressIndicator(),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ShopCubit.get(context).image == null ? NetworkImage(model.data.image) : FileImage(ShopCubit.get(context).image),
                        fit: BoxFit.cover,
                      ),
                  borderRadius: BorderRadius.circular(15),
                )
              ),
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo, color: Colors.green, size: 32,),
                  onPressed:(){
                    var alert = AlertDialog(
                      title: Text('choose picture from'),
                      content: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Divider(color: Colors.black,),
                            Container(
                              color: Colors.teal,
                              child: ListTile(
                                leading: Icon(Icons.photo),
                                title: Text('Gallery'),
                                onTap: ()async{
                                  final pickFile = await picker.getImage(source: ImageSource.gallery);
                                  if(pickFile != null)
                                  {
                                    ShopCubit.get(context).changeProfilePhoto(File( pickFile.path));
                                  }
                                  Navigator.of(context).pop();},
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(

                              color: Colors.teal,
                              child: ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Camera'),
                                onTap: ()async{
                                  final pickFile = await picker.getImage(source: ImageSource.camera);
                                  if(pickFile != null)
                                  {
                                    ShopCubit.get(context).changeProfilePhoto(File( pickFile.path));
                                  }
                                  Navigator.of(context).pop();},
                              ),
                            ),
                          ],
                        ),
                      ),

                    );
                    showDialog(context: context, builder: (BuildContext context) => alert);
                    } ,
                ),


            ]
            ),
            SizedBox(height: 30,),
            defaultProfileTextField(
              controller: nameController,
              alignment: TextAlign.center,
              prefixIcon: Text('Full Name'),
              suffixIcon: Icon(Icons.arrow_forward_ios, size: 18,),
              type: TextInputType.text,

            ),

            SizedBox(height: 20,),
            defaultProfileTextField(
              controller: phoneController,
              alignment: TextAlign.center,
              prefixIcon: Text('Phone Number',),
              suffixIcon: Icon(Icons.arrow_forward_ios, size: 18,),
              type: TextInputType.phone,

            ),

            SizedBox(height: 20,),
            defaultProfileTextField(
              controller: emailController,
              alignment: TextAlign.center,
              prefixIcon: Text('Email'),
              suffixIcon: Icon(Icons.arrow_forward_ios, size: 18,),
              type: TextInputType.emailAddress,

            ),
            SizedBox(height: 20,),
            defaultBotton(
                text: "Update",
                function: (){
                  ShopCubit.get(context).updateUserData(
                    email: emailController.text,
                    name: nameController.text,
                    phone: phoneController.text
                  );
                }
            ),
            SizedBox(height: 20,),
            defaultBotton(
                text: "LOGOUT",
                function: (){
                  ShopCubit.get(context).currentIndex=0;
                  ShopCubit.get(context).image=null;
                  singOut(context);
                }
            ),



          ],
        ),
      ),
    );
  }
}
