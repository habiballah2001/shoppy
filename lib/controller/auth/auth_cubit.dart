import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_data_model.dart';
import '../../view/modules/login&register/login_screen.dart';
import '../../res/data_source/end_points.dart';
import '../../res/data_source/local/cache_helper.dart';
import '../../res/data_source/remote/dio_helper.dart';
import '../../res/utils/custom_methods.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(RegisterInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  UserModel? _loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      _loginModel = UserModel.fromJson(value.data);
      getUserData();
      emit(LoginSuccessState(_loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      log('ERROR:${error.toString()}');
    });
  }

  void changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    DioHelper.postData(
      url: CHANGE_PASSWORD,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    ).then((value) {
      _loginModel = UserModel.fromJson(value.data);
      emit(LoginSuccessState(_loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      log('ERROR:${error.toString()}');
    });
  }

  ///reg

  UserModel? _userModel;
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      log(value.data);
      _userModel = UserModel.fromJson(value.data);
      getUserData();
      emit(RegisterSuccessState(_userModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      log(error.toString());
    });
  }

  ///user
  UserModel? userDataModel;
  void getUserData() {
    emit(LoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
    ).then((value) {
      emit(SuccessUserDataState(userDataModel));
      userDataModel = UserModel.fromJson(value.data);
      log(userDataModel.toString());
    }).catchError((error) {
      emit(ErrorUserDataState(error.toString()));
      log('ERROR IS ${error.toString()}');
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(LoadingUpdateUserDateState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      emit(SuccessUpdateUserDateState());
      userDataModel = UserModel.fromJson(value.data);
      log('${value.data}');
    }).catchError((error) {
      emit(ErrorUpdateUserDateState(error.toString()));
      log('ERROR IS ${error.toString()}');
    });
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        Utils.navigateAndFinish(
          widget: const LoginScreen(),
          context: context,
        );
      }
    }).catchError((e) {
      log('err in logout $e');
    });
  }
}
