import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/res/components/components.dart';
import 'package:shoppy/res/material/custom_card.dart';
import 'package:shoppy/res/material/custom_texts.dart';
import '../../../controller/auth/auth_cubit.dart';
import '../../../controller/auth/auth_states.dart';
import '../../../view/layout/shop_layout.dart';
import '../../../res/components/constants.dart';
import '../../../res/material/custom_button.dart';
import '../../../res/material/custom_text_field.dart';
import '../../../res/data_source/local/cache_helper.dart';
import '../../../res/utils/custom_methods.dart';
import '../../../res/utils/dialogs.dart';
import '../../../res/styles/colors.dart';
import 'register_screen.dart';

// reusable components

// 1. timing
// 2. refactor
// 3. quality
// 4. clean code

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel!.status!) {
            CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel!.data!.token.toString())
                .then((value) {
              Constants.token_ = state.loginModel!.data!.token!;
              Utils.navigateAndFinish(
                widget: const AppLayout(),
                context: context,
              );
            });
          } else {
            log(state.loginModel!.message.toString());
            Utils.toast(body: state.loginModel!.message.toString());
          }
        }
        if (state is LoginErrorState) {
          Dialogs.errorDialog(content: 'Error in login', context: context);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgColor,
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        height: 100,
                      ),
                      const SpaceHeight(),
                      const HeadSmallText(
                        'Login',
                        color: primaryColor,
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      CustomTextField(
                        controller: emailController,
                        hint: 'Email',
                        suffix: const Icon(Icons.email),
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return ' must be filled';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      PasswordTextField(
                        controller: passwordController,
                        label: 'Password',
                        type: TextInputType.visiblePassword,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return ' must be filled';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: CustomButton(
                          radius: 30,
                          title: 'login',
                          isUpperCase: true,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const BodySmallText(
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Utils.navigateTo(
                                widget: const RegisterScreen(),
                                context: context,
                              );
                            },
                            child: const TitleSmallText(
                              'Register',
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
    );
  }
}
