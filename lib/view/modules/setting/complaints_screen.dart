import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppy/controller/app_cubit/shop_cubit.dart';
import 'package:shoppy/controller/auth/auth_cubit.dart';
import 'package:shoppy/res/material/CustomAppBar.dart';
import 'package:shoppy/res/material/custom_button.dart';
import 'package:shoppy/res/material/custom_text_field.dart';
import 'package:shoppy/res/material/custom_texts.dart';
import 'package:shoppy/res/utils/custom_methods.dart';
import 'package:shoppy/res/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  var controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> openCall() async {
    final Uri phoneUrl = Uri.parse('tel://12355665');
    try {
      if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      } else {
        throw Exception('Could not launch $phoneUrl');
      }
    } catch (e) {
      log('ERROR ==== ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = AuthCubit.get(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: TitleMediumText('Complaints'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: controller,
              type: TextInputType.text,
              maxLines: 10,
              hint: 'Complaints...',
              validate: (p0) => Utils.validator(
                  value: p0!, returnedString: 'must be filled'),
            ),
            CustomButton(
              title: 'Send',
              function: () {
                if (formKey.currentState!.validate()) {
                  if (authCubit.userDataModel != null) {
                    AppCubit.get(context).sendComplaints(
                      userName: authCubit.userDataModel!.data!.name!,
                      phone: authCubit.userDataModel!.data!.phone!,
                      email: authCubit.userDataModel!.data!.email!,
                      msg: controller.text,
                      context: context,
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.call),
        onPressed: () async {
          openCall();
        },
      ),
    );
  }
}
