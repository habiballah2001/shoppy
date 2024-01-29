import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/auth/auth_cubit.dart';
import '../../controller/auth/auth_states.dart';
import '../../shared/components/constants.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_text_field.dart';
import '../../shared/data_source/local/cache_helper.dart';
import '../../shared/services/custom_methods.dart';
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
                CustomMethods.navigateAndFinish(
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
            body: Card(
              margin: const EdgeInsets.fromLTRB(48, 96, 48, 96),
              shadowColor: Colors.cyanAccent,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          CustomTextField(
                            controller: nameController,
                            hint: 'Name',
                            type: TextInputType.text,
                            prefix: const Icon(Icons.person),
                            validate: (p0) => 'Name must not be empty',
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            hint: 'Phone',
                            type: TextInputType.text,
                            prefix: const Icon(Icons.phone_android),
                            validate: (p0) => 'Phone must not be empty',
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomTextField(
                            controller: emailController,
                            hint: 'Email',
                            prefix: const Icon(Icons.email),
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
                              background: Colors.orangeAccent,
                              height: 40,
                              width: double.infinity,
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
                          const SizedBox(
                            height: 30.0,
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
                              Icon(Icons.facebook, size: 50),
                              Icon(Icons.apple, color: Colors.black, size: 50),
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
      ),
    );
  }
}
