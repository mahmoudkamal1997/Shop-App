import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

import 'cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context,state){},
        builder: (context,state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    defaultTextField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value){
                        if(value.isEmpty)
                          return 'Enter text to search';
                        return null;
                      },
                      onSubmit: (String text){
                        if(formKey.currentState.validate()) {
                          cubit.search(text);
                        }
                      },
                      label: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    SizedBox(height: 10,),
                    if(state is SearchOnLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildProductItem(context,cubit.searchModel.data.data[index]) ,
                        separatorBuilder: (context, index) => Container(width:double.infinity,height: 1, color: Colors.grey,),
                        itemCount: cubit.searchModel.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }

  Widget buildProductItem(context,ProductSearchModel model){
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Image(
              image: NetworkImage(model.image),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.cover
          ),


          SizedBox(width :MediaQuery.of(context).size.width * 0.04,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.5,
                      fontSize: 24
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      'Price: ${model.price}',
                      style: TextStyle(
                          fontSize: 18,
                          color: defaultColor
                      ),

                    ),


                  ],
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}