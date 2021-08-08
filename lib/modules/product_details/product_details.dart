
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/style/colors.dart';

class ProductDetails extends StatelessWidget {

  final ProductModel model;

  const ProductDetails(this.model);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: defaultColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.4,

                  ),
                  if(model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),
                    ),
                ]
              ),
              SizedBox(height:MediaQuery.of(context).size.height * 0.01,),
              Container(width:double.infinity,height: 1, color: Colors.grey,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  model.name,
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.5,
                      fontSize: 24
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(width:double.infinity,height: 1, color: Colors.grey,),
              SizedBox(height:MediaQuery.of(context).size.height * 0.01,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(

                  children: [
                    Text(
                      'Price: ${model.price.round()}',
                      style: TextStyle(
                          fontSize: 20,
                          color: defaultColor
                      ),

                    ),
                    SizedBox(width:MediaQuery.of(context).size.height * 0.01,),
                    if(model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                    ]
                ),
              ),
              Container(width:double.infinity,height: 1, color: Colors.grey,),
              SizedBox(height:MediaQuery.of(context).size.height * 0.02,),
              Text(
                "Description:",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold

                ),
              ),
              Text(
                model.description,
                style: TextStyle(
                    fontSize: 20,

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
