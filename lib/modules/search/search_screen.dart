import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/app_cubit/shop_cubit.dart';
import '../../controller/app_cubit/shop_states.dart';
import '../../shared/custom_widgets/CustomAppBar.dart';
import '../../shared/custom_widgets/custom_text_field.dart';
import '../../widgets/products/search_product.dart';

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
          appBar: const CustomAppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is LoadingSearchState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    compColor: Colors.white,
                    controller: searchController,
                    type: TextInputType.text,
                    filledColor: const Color(0xff153075),
                    validate: (p0) => 'Search Here',
                    onSubmit: (v) => cubit.searchProducts(v!),
                    hint: 'Search',
                    prefix: const Icon(Icons.search_outlined),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is SuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => SearchProduct(
                          product: cubit.searchModel!.data!.data[index],
                        ),
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: cubit.searchModel!.data!.data.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
