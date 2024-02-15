import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/view/widgets/home/categories_section.dart';
import 'package:shoppy/view/widgets/home/products_section.dart';
import '../../../res/components/components.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../controller/app_cubit/shop_states.dart';
import '../../../res/material/cached_image.dart';
import '../../../res/material/custom_container.dart';
import '../../../res/material/custom_search_bar.dart';
import '../../../res/material/slider/custom_carousel_slider.dart';
import '../../../res/utils/custom_methods.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AppCubit.get(context)
      ..getHomeData()
      ..getCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSearchBar(
                onTab: () {
                  Utils.navigateTo(
                      widget: const SearchScreen(), context: context);
                },
              ),
              const SpaceHeight(),
              SizedBox(
                height: 180,
                child: cubit.homeModel != null
                    ? CustomCarouselSlider(
                        height: 180,
                        items: cubit.homeModel!.data!.banners.map((url) {
                          return CustomContainer(
                            child: CustomCachedImage(img: url.image!),
                          );
                        }).toList())
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              categoriesSection(context),
              productsSection(context),
            ],
          ),
        );
      },
    );
  }
}
