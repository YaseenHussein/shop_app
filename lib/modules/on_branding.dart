import 'package:flutter/material.dart';
import 'package:shop_app/shared/componts.dart/componnts.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login/login.dart';

class OnBoardingModel {
  String img;
  String title;
  String titleBody;
  OnBoardingModel({
    required this.img,
    required this.title,
    required this.titleBody,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController();
  bool isLast = false;
  List<OnBoardingModel> listOnBoarding = [
    OnBoardingModel(
      img: "assets/images/image0.png",
      title: "title On Boarding 0",
      titleBody: "title Body On Boarding 0",
    ),
    OnBoardingModel(
      img: "assets/images/image1.png",
      title: "title On Boarding 1",
      titleBody: "title Body On Boarding 1",
    ),
    OnBoardingModel(
      img: "assets/images/image2.png",
      title: "title On Boarding 2",
      titleBody: "title Body On Boarding 2",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPress: () {
                onSubmit(context);
              },
              label: "Skip")
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: (value) {
                if (value == listOnBoarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) => buildPageView(
                listOnBoarding[index],
              ),
              itemCount: listOnBoarding.length,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              //////////////////////هذا الاندكيتور
              SmoothPageIndicator(
                controller:
                    pageController, // تعريف الكنترولار من اجل التحكم باموقع الانكيتور باموجب البيج فيو
                count: listOnBoarding.length, //عدد الاندكيتور
                effect: ExpandingDotsEffect(
                  //شكل الاندكبتور ايش من نوع
                  dotColor: Colors.grey,
                  activeDotColor: defaultColorThem, //عندما يكون واقف عليه
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 5,
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (isLast) {
                    //////////اذهب الى الاصل
                    onSubmit(context);
                  } else {
                    ///////////// الانتقال من صفحة الى صفحة//////////////
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                    //////////////////////////////
                  }
                },
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

Widget buildPageView(OnBoardingModel list) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(list.img),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          list.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontFamily: 'font1',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          list.titleBody,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontFamily: 'LBC Regular',
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
void onSubmit(context) {
  CacheHelper.putData(key: "onBoarding", value: false);
  navigatorFinish(context, const LoginScreen());
}
