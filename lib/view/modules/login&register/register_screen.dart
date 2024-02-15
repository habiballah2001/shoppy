import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/res/components/components.dart';
import 'package:shoppy/res/material/custom_card.dart';
import 'package:shoppy/res/material/custom_texts.dart';
import '../../../controller/auth/auth_cubit.dart';
import '../../../controller/auth/auth_states.dart';
import '../../../res/components/constants.dart';
import '../../../res/material/custom_button.dart';
import '../../../res/material/custom_text_field.dart';
import '../../../res/data_source/local/cache_helper.dart';
import '../../../res/styles/colors.dart';
import '../../../res/utils/custom_methods.dart';
import 'login_screen.dart';
import 'dart:developer';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel!.status!) {
              CacheHelper.saveData(
                      key: 'token',
                      value: state.loginModel!.data!.token.toString())
                  .then((value) {
                Constants.token_ = state.loginModel!.data!.token!;
                Utils.navigateAndFinish(
                  widget: const LoginScreen(),
                  context: context,
                );
              });
            } else {
              log(state.loginModel!.message.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${state.loginModel!.message}")));
            }
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          height: 100,
                        ),
                        const SpaceHeight(),
                        const HeadSmallText(
                          'Register',
                          color: primaryColor,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomTextField(
                          controller: nameController,
                          hint: 'Name',
                          type: TextInputType.text,
                          suffix: const Icon(Icons.person),
                          validate: (p0) => 'Name must not be empty',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField(
                          controller: phoneController,
                          hint: 'Phone',
                          type: TextInputType.text,
                          suffix: const Icon(Icons.phone_android),
                          validate: (p0) => 'Phone must not be empty',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hint: 'Email',
                          suffix: const Icon(Icons.email),
                          type: TextInputType.emailAddress,
                          validate: (p0) => 'email must not be empty',
                        ),
                        const SizedBox(
                          height: 11.0,
                        ),
                        PasswordTextField(
                          controller: passwordController,
                          label: 'Password',
                          type: TextInputType.visiblePassword,
                          validate: (p0) => 'password is too short',
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: CustomButton(
                            radius: 30,
                            title: 'Sign up',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const BodySmallText(
                              'have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Utils.navigateTo(
                                  widget: const LoginScreen(),
                                  context: context,
                                );
                              },
                              child: const TitleSmallText(
                                'Login',
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
