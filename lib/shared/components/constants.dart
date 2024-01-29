import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/controller/app_cubit/shop_cubit.dart';
import 'package:shoppy/controller/app_cubit/shop_states.dart';
import '../../models/home/on_boarding_model.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/home/HomeScreen.dart';
import '../../modules/setting/settings_screen.dart';
import '../custom_widgets/cached_image.dart';

class Constants {
  static String personalImg =
      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=2000';
  static String? token_;
}

class Lists {
  static List<Color> colors = [
    Colors.deepOrange,
    Colors.red,
    Colors.yellow,
  ];

  static List<Widget> banners = [
    const CustomCachedImage(
      img:
          'https://thumbs.dreamstime.com/b/special-offer-banner-red-design-web-154136227.jpg',
    ),
    const CustomCachedImage(
      img:
          'https://thumbs.dreamstime.com/b/final-sale-banner-clearance-offer-discout-layout-yellow-background-special-percents-off-template-design-list-page-198240479.jpg',
    ),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: CustomCachedImage(
        img:
            'https://thumbs.dreamstime.com/b/black-friday-sale-banner-background-design-template-poster-flyer-social-media-website-mobile-development-email-newsletter-196488156.jpg',
      ),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: CustomCachedImage(
        img:
            'https://thumbs.dreamstime.com/b/calligraphy-thanksgiving-day-sale-banner-seasonal-lettering-vector-illustration-calligraphy-thanksgiving-day-sale-banner-155224704.jpg',
      ),
    ),
  ];
  static List<BoardingModel> boarding = [
    BoardingModel(
      img: 'assets/images/splash_1.svg',
      title: 'Welcome to Shoppy, Let’s shop!',
      body: 'Let\'s go',
    ),
    BoardingModel(
      img: 'assets/images/splash_2.svg',
      title: 'We help people connect with store around United State of America',
      body: 'Buy our products',
    ),
    BoardingModel(
      img: 'assets/images/splash_3.svg',
      title: 'We show the easy way to shop. \nJust stay at home with us',
      body: 'for your usage',
    ),
  ];

  static List<String> titles = [
    'Products',
    'Categories',
    'Favorites',
    'Carts',
    'Setting',
  ];
  static List<Widget> bottomScreens = const [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
    SettingsScreen()
  ];
  static List<BottomNavigationBarItem> bottomItems({
    required BuildContext context,
  }) =>
      [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            size: 24,
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.category,
            size: 24,
          ),
          label: 'Category',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 24,
          ),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              AppCubit cubit = AppCubit.get(context);
              return state is SuccessGetCartState &&
                      cubit.getCartModel!.cartData!.cartItems.isNotEmpty
                  ? Badge(
                      label: Text(cubit.getCartModel!.cartData!.cartItems.length
                              .toString() ??
                          ''),
                      child: const Icon(
                        Icons.shopping_bag,
                      ),
                    )
                  : const Icon(
                      Icons.shopping_bag,
                    );
            },
          ),
          label: 'cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.design_services,
            size: 24,
          ),
          label: 'Services',
        ),
      ];
}
