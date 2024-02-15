import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../controller/app_cubit/shop_states.dart';
import '../../../res/material/empty_widget.dart';
import '../../../view/widgets/products/product_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AppCubit.get(context).getFavoritesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! LoadingFavState && cubit.getFavModel != null
            ? cubit.getFavModel!.data!.dataList.isNotEmpty
                ? GridView.count(
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1 / 1.6,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                      cubit.getFavModel!.data!.dataList.length,
                      (index) {
                        return ProductItem(
                          product:
                              cubit.getFavModel!.data!.dataList[index].product,
                        );
                      }, //?? 1
                    ),
                  )
                : const Center(
                    child: EmptyWidget(
                      icon: Icons.heart_broken_outlined,
                      title: 'Empty',
                      withExpanded: false,
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
