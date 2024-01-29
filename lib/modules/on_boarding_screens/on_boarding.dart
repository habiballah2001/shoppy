import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/home/on_boarding_model.dart';
import '../../shared/data_source/local/cache_helper.dart';
import '../../shared/services/custom_methods.dart';
import '../../shared/styles/colors.dart';

import '../login&register/login_screen.dart';
import 'dart:developer';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoard', value: true).then((value) {
      CustomMethods.navigateAndFinish(
        widget: const LoginScreen(),
        context: context,
      );
    }).catchError((error) {
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) => buildBoardItem(
                  Lists.boarding[index],
                ),
                itemCount: Lists.boarding.length,
                onPageChanged: (index) {
                  if (index == Lists.boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.deepOrange),
                  controller: boardController,
                  count: Lists.boarding.length,
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardItem(BoardingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                model.title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                model.body,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 100,
                      color: Color(0xff9EB7E5),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                model.img,
                height: 400,
              )
            ],
          ),
        ],
      );
}
