import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/res/material/custom_text_field.dart';
import '../../../../controller/auth/auth_cubit.dart';
import '../../../../controller/auth/auth_states.dart';
import '../../../../res/components/components.dart';
import '../../../../res/material/CustomAppBar.dart';
import '../../../../res/material/custom_button.dart';
import '../../../../res/material/custom_texts.dart';
import '../../../../res/utils/custom_methods.dart';

class ProfileScreen extends StatefulWidget {
  //final UserModel userModel;

  const ProfileScreen({
    super.key,
    //required this.userModel,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();

  //text controllers
  late TextEditingController nameController;

  late TextEditingController emailController;

  late TextEditingController phoneController;

  //focus node
  FocusNode nameFocusNode = FocusNode();

  FocusNode emailFocusNode = FocusNode();

  FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    AuthCubit.get(context).getUserData();
    AuthCubit cubit = AuthCubit.get(context);
    nameController =
        TextEditingController(text: cubit.userDataModel!.data!.name ?? '');
    emailController =
        TextEditingController(text: cubit.userDataModel!.data!.email ?? '');
    phoneController =
        TextEditingController(text: cubit.userDataModel!.data!.phone ?? '');
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      nameController.dispose();
      emailController.dispose();
      phoneController.dispose();

      //
      nameFocusNode.dispose();
      emailFocusNode.dispose();
      phoneFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = AuthCubit.get(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Profile'),
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userData = AuthCubit.get(context).userDataModel;
          return userData != null
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: [
                          const SpaceHeight(height: 30),
                          const TitleSmallText('User name'),
                          CustomTextField(
                            controller: nameController,
                            focusNode: nameFocusNode,
                            textInputAction: TextInputAction.next,
                            hint: 'Full Name',
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(emailFocusNode),
                            type: TextInputType.text,
                            validate: (value) {
                              return Utils.validator(
                                value: value!,
                                returnedString: ' must be filled',
                              );
                            },
                          ),
                          const SpaceHeight(),
                          const TitleSmallText('E-mail'),
                          CustomTextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            type: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            hint: 'email',
                            onEditingComplete: () => authCubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text),
                            onSubmit: (v) => authCubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text),
                            onChange: (p0) {
                              log(phoneController.text);
                            },
                            validate: (value) {
                              return Utils.validator(
                                value: value!,
                                returnedString: ' must be filled',
                              );
                            },
                          ),
                          const TitleSmallText('Phone'),
                          CustomTextField(
                            controller: phoneController,
                            focusNode: phoneFocusNode,
                            type: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            maxLength: 11,
                            hint: 'phone',
                            onEditingComplete: () => authCubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text),
                            onSubmit: (v) => authCubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text),
                            onChange: (p0) {
                              log(phoneController.text);
                            },
                            validate: (value) {
                              return Utils.validator(
                                value: value!,
                                returnedString: ' must be filled',
                              );
                            },
                          ),
                          const SpaceHeight(),
                          CustomButton(
                            title: 'Edit',
                            radius: 10,
                            load: state is LoadingUpdateUserDateState,
                            function: () => authCubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
