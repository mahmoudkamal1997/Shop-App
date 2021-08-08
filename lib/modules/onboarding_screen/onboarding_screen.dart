import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();
  bool isLast = false;

  List<OnboaringModel> items = [
    OnboaringModel(
      image: 'assets/images/shopapponboarding1.jpg',
      title: 'Salla app',
      bodyText: 'Search for items near you'
    ),
    OnboaringModel(
        image: 'assets/images/shopapponboarding2.jpg',
        title: 'Salla app',
        bodyText: 'Discover many of items for you'
    ),
    OnboaringModel(
        image: 'assets/images/shopapponboarding3.jpg',
        title: 'Salla app',
        bodyText: 'nice App using for shoppong'
    ),
  ];

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        NavigateToAndReplacement(context, LoginScreen());
        print("login screen");
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              submit();
            },
           child: Text('SKIP',style:TextStyle(fontSize: 24),)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (index){
                  if(index == items.length - 1)
                    {
                      setState((){
                        isLast = true;
                      });
                    }else{
                      setState((){
                        isLast = false;
                      });
                  }

                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) =>buildPageView(items[index]) ,
                itemCount: items.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor ,
                    spacing: 5.0,
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3
                  ),
                  count: items.length,
                ),
                Spacer(),
                FloatingActionButton(
                    child: Icon(Icons.arrow_forward_ios),
                    onPressed: (){
                      if(isLast){
                        submit();
                      }
                      else{
                        boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);

                      }
                    }
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildPageView(OnboaringModel model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        Text("${model.title}",style: TextStyle(fontSize: 24),),
        SizedBox(height: 20,),
        Text("${model.bodyText}",style: TextStyle(fontSize: 18),),
      ],
    );
  }
}

