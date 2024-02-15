import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/controller/app_cubit/shop_cubit.dart';
import 'package:shoppy/controller/app_cubit/shop_states.dart';
import 'package:shoppy/res/components/components.dart';
import 'package:shoppy/res/material/CustomAppBar.dart';
import 'package:shoppy/res/material/custom_texts.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            appBar: const CustomAppBar(
              title: TitleMediumText('FAQs'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: cubit.faqModel != null && state is! LoadingFAQsState
                  ? ListView.separated(
                      itemCount: cubit.faqModel!.data!.data!.length,
                      separatorBuilder: (context, index) => const SpaceHeight(),
                      itemBuilder: (context, index) {
                        final item = cubit.faqModel!.data!.data![index];
                        return FQSItem(
                          question: item.question ?? '',
                          answer: item.answer ?? '',
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ));
      },
    );
  }
}

class FQSItem extends StatelessWidget {
  final String question;
  final String answer;
  const FQSItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleMediumText(
          question,
        ),
        BodyLargeText(
          answer,
        ),
      ],
    );
  }
}
