import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return cubit.categoriesModel != null? Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.003,
              crossAxisSpacing: MediaQuery.of(context).size.height * 0.003,
              childAspectRatio: 1/1,
              physics: BouncingScrollPhysics(),
              children: List.generate(
                cubit.categoriesModel.data.data.length,
                (index) => buildCategoriesItem(context,cubit.categoriesModel.data.data[index])
              ),
            ),
          ) : Center(child: CircularProgressIndicator(),);
        }
    );
  }
  Widget buildCategoriesItem (context,DataModel model) => Container(
    color: Colors.white,
    padding: EdgeInsets.all(12),
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2,
          fit:BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
          width: double.infinity,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}