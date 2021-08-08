import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_user_model.dart';
import 'package:shop_app/modules/categories/category_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/shared/network/file_endpoint.dart';
import 'package:shop_app/shared/network/remote/http_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  int currentIndex = 0;
  List<Widget> bottomScreens=[
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  Map<int ,bool> favorites ={};
  HomeModel homeModel;
  CategoriesModel categoriesModel;
  ChangeFavoriteModel changeFavoriteModel;
  FavoriteModel favoriteModel;
  ShopLoginModel userModel;
  ShopLoginModel tempModel;
  ShopCubit(): super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  File image ;
  void changeProfilePhoto(File img){
    image = img;
    emit(ShopProfilePhotoState());
  }

  void changeBottomScreen(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData()async{
    emit(ShopOnLoadingDataState());
    var response = await HttpHelper.getData(
      url :'https://student.valuxapps.com/api/home',
      token: token,
    );
    if(response.statusCode == 200){
      //print(response.body);
      homeModel = HomeModel.fromJson(json.decode(response.body));
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites
        });
      });

      emit(ShopSuccessHomeDataState());
    }
    else{
      print(" server not found");
      emit(ShopErrorHomeDataState(" server not found"));
    }
  }

  void getCategoriesData()async{
    emit(ShopOnLoadingDataState());
    var response = await HttpHelper.getData(
      url :'https://student.valuxapps.com/api/categories',
      token: token,
    );
    if(response.statusCode == 200){
      //print(response.body);
      categoriesModel = CategoriesModel.fromJson(json.decode(response.body));
      emit(ShopSuccessHomeDataState());
    }
    else{
      print(" server not found");
      emit(ShopErrorHomeDataState(" server not found"));
    }
  }

  void changeFavoriteItems(int productId) async{
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoriteDataState());
    var response = await HttpHelper.postData(
      url :'https://student.valuxapps.com/api/favorites',
      data: <String, int>{
        'product_id' : productId
      },
      token: token
    );
    if(response.statusCode == 200){

      changeFavoriteModel = ChangeFavoriteModel.fromJson(json.decode(response.body));
      if(!changeFavoriteModel.status)
        {
          favorites[productId] = !favorites[productId];
        }else{
        getFavoriteData();
      }
      emit(ShopSuccessChangeFavoriteDataState(changeFavoriteModel));
    }
    else{
      favorites[productId] = !favorites[productId];
      print(" server not found");
      emit(ShopErrorChangeFavoriteDataState(" server not found"));
    }
  }

  void getFavoriteData()async{
    emit(ShopOnLoadingFavoriteDataState());
    var response = await HttpHelper.getData(
      url :'https://student.valuxapps.com/api/favorites',
      token: token,
    );
    if(response.statusCode == 200){
      //print(response.body);
      favoriteModel = FavoriteModel.fromJson(json.decode(response.body));
      print(favoriteModel.data.data.length);
      emit(ShopSuccessFavoriteDataState());
    }
    else{
      print(" server not found");
      emit(ShopErrorFavoriteDataState(" server not found"));
    }
  }

  void getUserData()async{
    emit(ShopOnLoadingUserDataState());
    var response = await HttpHelper.getData(
      url :'https://student.valuxapps.com/api/profile',
      token: token,
    );
    if(response.statusCode == 200){
      //print(response.body);
      userModel = ShopLoginModel.fromJson(json.decode(response.body));
      emit(ShopSuccessGetUserDataState(userModel));
    }
    else{
      print(" server not found");
      emit(ShopErrorGetUserDataState(" server not found"));
    }
  }

  void updateUserData({
    @required String email,
    @required String name,
    @required String phone,
  })async{
    emit(ShopOnLoadingUpdateUserDataState());
    List<int> imageBytes = image.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    var response = await HttpHelper.updateData(
      url :'https://student.valuxapps.com/api/update-profile',
      token: token,
      data: <String, String>{
        "name": name,
        "phone": phone,
        "email": email,
        "image": baseimage??''
      },
    );
    print('done');
    if(response.statusCode == 200){
      print(response.body);
      var model = json.decode(response.body);
      if(model['status'] == true) {
        userModel = ShopLoginModel.fromJson(json.decode(response.body));
        emit(ShopSuccessUpdateUserDataState(userModel));
      }else{
        tempModel = ShopLoginModel.fromJson(json.decode(response.body));
        emit(ShopSuccessUpdateUserDataState(tempModel));
      }

    }
    else{
      print(" server not found");
      emit(ShopErrorUpdateUserDataState(" server not found"));
    }
  }

}