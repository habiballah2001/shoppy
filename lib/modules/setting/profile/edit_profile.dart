import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/shared/services/app_methods.dart';
import '../../../controller/auth/auth_cubit.dart';
import '../../../controller/auth/auth_states.dart';
import '../../../shared/custom_widgets/custom_button.dart';
import 'dart:developer';

import '../../../shared/custom_widgets/custom_text_field.dart';

class EditProfile extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        nameController.text = cubit.userDataModel!.data!.name!;
        emailController.text = cubit.userDataModel!.data!.email!;
        phoneController.text = cubit.userDataModel!.data!.phone!;
        log(cubit.userDataModel!.data!.name.toString());
        log(cubit.userDataModel!.data!.email.toString());
        log(cubit.userDataModel!.data!.phone.toString());
        return cubit.userDataModel!.data != null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is LoadingUserDataState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (p0) => 'enter name',
                        hint: 'Name',
                        prefix: const Icon(Icons.person),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (p0) => 'enter email',
                        hint: 'E-mail',
                        prefix: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (p0) => 'enter phone',
                        hint: 'Phone',
                        prefix: const Icon(Icons.phone_android),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        radius: 10,
                        height: 40,
                        width: double.infinity,
                        title: 'Update',
                        background: Colors.orangeAccent,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomButton(
                        radius: 10,
                        width: double.infinity,
                        height: 40,
                        background: Colors.orangeAccent,
                        title: 'Sign out',
                        function: () {
                          AppMethods.signOut(context);
                        },
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
