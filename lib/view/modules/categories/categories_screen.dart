import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/res/utils/custom_methods.dart';
import '../../../models/category/category_model.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../controller/app_cubit/shop_states.dart';
import '../../../res/material/custom_card.dart';
import '../../widgets/category_item.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AppCubit.get(context).getCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return cubit.categoriesModel != null
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => CategoryItem(
                  index: index,
                  model:
                      cubit.categoriesModel!.categoriesData!.finalData[index],
                ),
                itemCount:
                    cubit.categoriesModel!.categoriesData!.finalData.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildInCategory(
      CategoryItemModel model, BuildContext context, int index) {
    AppCubit cubit = AppCubit.get(context);
    return GestureDetector(
      onTap: () {
        cubit.getCategoryProducts(
            cubit.categoriesModel!.categoriesData!.finalData[index].id!);
        Utils.navigateTo(
          widget: CategoryProductsScreen(
            categoryName:
                cubit.categoriesModel!.categoriesData!.finalData[index].name!,
          ),
          context: context,
        );
      },
      child: CustomCard(
        child: Row(
          children: [
            Image(
              width: 100,
              height: 100,
              image: NetworkImage(model.image!),
            ),
            Text(model.name!),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
