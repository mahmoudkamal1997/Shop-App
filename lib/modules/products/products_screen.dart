import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

class ProductScreen extends StatelessWidget {
  @override
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
        return cubit.homeModel != null && cubit.categoriesModel != null ? productsScreenBuilder(context,cubit.homeModel,cubit.categoriesModel) : Center(child: CircularProgressIndicator(),);
      }
    );
  }

  Widget productsScreenBuilder(BuildContext context,HomeModel model,CategoriesModel categoriesModel){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners.map((element) {
              return Image(
                image: NetworkImage(element.image),
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.25,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
            )
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w800),),
                SizedBox(height: 15,),
                Container(
                  height: MediaQuery.of(context).size.height *0.15,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=> buildCategoriesItem (context,categoriesModel.data.data[index]),
                    separatorBuilder: (context,index)=> SizedBox(width: 5,),
                    itemCount: categoriesModel.data.data.length,
                  ),
                ),
                SizedBox(height: 15,),
                Text('New Products',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w800),),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.003,
                crossAxisSpacing: MediaQuery.of(context).size.height * 0.003,
                childAspectRatio: 1/1.47,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(model.data.products.length, (index) => buildProductItem(context,model.data.products[index]) ),
              ),
          ),

        ],
      ),
    );
  }


  Widget buildCategoriesItem (context,DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        height: MediaQuery.of(context).size.height *0.15,
        width: MediaQuery.of(context).size.width *0.3,
        fit:BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.5),
        width: MediaQuery.of(context).size.width *0.3,
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
  );
  Widget buildProductItem(context, model){
    return InkWell(
      onTap: (){
        NavigateTo(context, ProductDetails(model));
      },
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,

                  ),
                  if(model.discount != 0)
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
              SizedBox(height:MediaQuery.of(context).size.height * 0.01,),
              Text(
                model.name,
                maxLines: 2,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 14
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    'Price: ${model.price.round()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: defaultColor
                    ),

                  ),
                  SizedBox(width:MediaQuery.of(context).size.height * 0.01,),
                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                    ),

                  ),
                  Spacer(),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey ,
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                        size: 20,
                      )
                    ),
                    onPressed: (){
                      ShopCubit.get(context).changeFavoriteItems(model.id);
                    }
                  )
                ],
              ),
            ],
          ),

      ),
    );
  }
}
