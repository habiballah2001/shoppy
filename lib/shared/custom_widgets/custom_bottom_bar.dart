import 'dart:developer';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'custom_card.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  static int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //var currentIndex = 0;

    List<BottomNavyBarItem> bottomItems = [
      BottomNavyBarItem(
        icon: const Icon(
          Icons.home_filled,
          size: 24,
        ),
        title: const Text('Home'),
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
      ),
      BottomNavyBarItem(
        icon: const Icon(
          Icons.category_outlined,
          size: 24,
        ),
        title: const Text(' Category'),
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
      ),
      BottomNavyBarItem(
        icon: const Icon(
          Icons.favorite,
          size: 24,
        ),
        title: const Text('Favoritescustom_widget'),
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
      ),
      BottomNavyBarItem(
        icon: const Icon(
          Icons.shopping_bag_rounded,
          size: 24,
        ),
        title: const Text('Cart'),
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
      ),
      BottomNavyBarItem(
        icon: const Icon(
          Icons.design_services,
          size: 24,
        ),
        title: const Text('Services'),
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
      ),
    ];

    void changeBottomNavBar(int index) {
      currentIndex = index;
      log('$currentIndex');
    }

    return SafeArea(
      child: CustomCard(
        color: primaryColor,
        radius: 40,
        padding: 5,
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8, top: 3),
        child: BottomNavyBar(
          curve: Curves.easeInCirc,
          backgroundColor: primaryColor,
          iconSize: 30,
          containerHeight: 60,
          selectedIndex: currentIndex,
          showElevation: false,
          items: bottomItems,
          onItemSelected: (value) {
            changeBottomNavBar(value);
          },
        ),
      ),
    );
  }
}
