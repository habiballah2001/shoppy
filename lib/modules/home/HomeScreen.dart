import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../controller/app_cubit/shop_states.dart';
import '../../shared/custom_widgets/cached_image.dart';
import '../../shared/custom_widgets/custom_container.dart';
import '../../shared/custom_widgets/custom_search_bar.dart';
import '../../shared/custom_widgets/custom_texts.dart';
import '../../shared/custom_widgets/slider/custom_carousel_slider.dart';
import '../../shared/services/custom_methods.dart';
import '../../widgets/category_item.dart';
import '../../widgets/products/product_item.dart';
import 'product_details_screen.dart';
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
                  CustomMethods.navigateTo(
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleLargeText(
                      'Categories',
                    ),
                    const SpaceHeight(),
                    SizedBox(
                      height: 116,
                      child: cubit.categoriesModel != null
                          ? ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  CategoryItemCircle(
                                model: cubit.categoriesModel!.categoriesData!
                                    .finalData[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  const SpaceWidth(),
                              itemCount: cubit.categoriesModel!.categoriesData!
                                  .finalData.length,
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleLargeText(
                      'Products',
                    ),
                    cubit.homeModel != null
                        ? GridView.count(
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 1,
                            childAspectRatio: 1 / 1.4,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: List.generate(
                              cubit.homeModel!.data!.products.length,
                              (index) => ProductItem(
                                itemIndex: index,
                                product: cubit.homeModel!.data!.products[index],
                                press: () {
                                  CustomMethods.navigateTo(
                                    widget: DetailsScreen(
                                      product: cubit
                                          .homeModel!.data!.products[index],
                                    ),
                                    context: context,
                                  );
                                },
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
