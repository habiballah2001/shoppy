import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/shared/custom_widgets/custom_texts.dart';
import '../../controller/auth/auth_cubit.dart';
import '../../controller/auth/auth_states.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_text_field.dart';
import '../../shared/data_source/local/cache_helper.dart';
import '../../shared/services/custom_methods.dart';
import '../../shared/services/dialogs.dart';
import '../../shared/styles/colors.dart';
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
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
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
              CustomMethods.navigateAndFinish(
                widget: const AppLayout(),
                context: context,
              );
            });
          } else {
            log(state.loginModel!.message.toString());
            CustomMethods.toast(body: state.loginModel!.message.toString());
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
          body: Card(
            margin: const EdgeInsets.fromLTRB(48, 160, 48, 160),
            shadowColor: Colors.cyanAccent,
            semanticContainer: true,
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
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
                            background: Colors.orangeAccent,
                            height: 40,
                            width: double.infinity,
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
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Forget Password?'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.grey[400],
                              height: 1,
                              width: 100,
                            ),
                            const Spacer(),
                            const Text('or'),
                            const Spacer(),
                            Container(
                              color: Colors.grey[400],
                              height: 1,
                              width: 100,
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.facebook, color: Colors.blue, size: 50),
                            Icon(Icons.apple, color: Colors.black, size: 50),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                CustomMethods.navigateTo(
                                  widget: const RegisterScreen(),
                                  context: context,
                                );
                              },
                              child: const TitleSmallText(
                                'Sign up',
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
          ),
        );
      },
    );
  }
}
