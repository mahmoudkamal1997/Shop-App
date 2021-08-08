import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

class FavoriteScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoriteDataState){
            if(state.model.status){
              showToast(message: state.model.message,state: toastState.SUCCESS);
            }else{
              showToast(message: state.model.message,state: toastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
           if(cubit.favoriteModel != null) {
            if(cubit.favoriteModel.data.data.length > 0) {
              return ListView.separated(
                itemBuilder: (context, index) => buildProductItem(context,cubit.favoriteModel.data.data[index]) ,
                separatorBuilder: (context, index) => Container(width:double.infinity,height: 1, color: Colors.grey,),
                itemCount: cubit.favoriteModel.data.data.length,
              );
            }else {
              return Center(child: Text('No favorite item yet'),);
            }
          }else {
            return Center(child: CircularProgressIndicator(),) ;
          }
        }
    );
  }

  Widget buildProductItem(context,Data model){
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product.image),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover
                ),
                if(model.product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white
                      ),
                    ),
                  ),
              ]
          ),
          SizedBox(width :MediaQuery.of(context).size.width * 0.04,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
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
                      'Price: ${model.product.price}',
                      style: TextStyle(
                          fontSize: 18,
                          color: defaultColor
                      ),

                    ),
                    SizedBox(width:MediaQuery.of(context).size.height * 0.01,),
                    if(model.product.discount != 0)
                      Text(
                        '${model.product.oldPrice}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                    Spacer(),
                    IconButton(
                        icon: CircleAvatar(
                            radius: 15.0,
                           backgroundColor:  defaultColor  ,
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                              size: 20,
                            )
                        ),
                        onPressed: (){
                          ShopCubit.get(context).changeFavoriteItems(model.product.id);
                        }
                    )
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