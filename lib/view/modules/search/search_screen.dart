import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/res/material/custom_search_bar.dart';
import 'package:shoppy/res/material/custom_texts.dart';
import 'package:shoppy/res/material/empty_widget.dart';
import '../../../controller/app_cubit/shop_cubit.dart';
import '../../../controller/app_cubit/shop_states.dart';
import '../../../res/material/CustomAppBar.dart';
import '../../../view/widgets/products/search_product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final formKey = GlobalKey<FormState>();

  final searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: const CustomAppBar(
            title: TitleMediumText('Search'),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is LoadingSearchState)
                    const LinearProgressIndicator(),
                  CustomSearchBar(
                    controller: searchController,
                    onSubmit: (v) => cubit.searchProducts(v!),
                    onChanged: (v) => cubit.searchProducts(v!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is LoadingSearchState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : cubit.searchModel!.data!.data.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) => SearchProduct(
                                  product: cubit.searchModel!.data!.data[index],
                                ),
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: cubit.searchModel!.data!.data.length,
                              ),
                            )
                          : const EmptyWidget(
                              title: 'Empty...',
                              svg: 'assets/images/empty_search.svg'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
