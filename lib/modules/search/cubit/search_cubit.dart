import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_state.dart';
import 'package:shop_app/shared/network/file_endpoint.dart';
import 'package:shop_app/shared/network/remote/http_helper.dart';

class SearchCubit extends Cubit<SearchState>{


  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel ;

  void search (String text)async{
    emit(SearchOnLoadingState());
    var response = await HttpHelper.postData(
        url :'https://student.valuxapps.com/api/products/search',
        data: <String, String>{
          'text' : text,
        },
      token: token,
    );
    if(response.statusCode == 200){

      searchModel = SearchModel.fromJson(json.decode(response.body));

      emit(SearchSuccessState());
    }
    else{
      print(" server not found");
      emit(SearchErrorState(" server not found"));
    }
  }
}