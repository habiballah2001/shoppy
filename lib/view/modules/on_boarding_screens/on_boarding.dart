import 'package:flutter/material.dart';
import 'package:shoppy/res/components/constants.dart';
import 'package:shoppy/view/widgets/board_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../res/data_source/local/cache_helper.dart';
import '../../../res/utils/custom_methods.dart';
import '../../../res/styles/colors.dart';

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
      Utils.navigateAndFinish(
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
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) => BoardItem(
                  model: Lists.boarding[index],
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
                  effect: const ExpandingDotsEffect(activeDotColor: secColor),
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
}
