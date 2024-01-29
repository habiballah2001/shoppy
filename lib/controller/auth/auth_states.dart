import '../../models/user_data_model.dart';

abstract class AuthStates {}

class LoginInitialState extends AuthStates {}

///user

//USER DATA
class LoadingUserDataState extends AuthStates {}

class SuccessUserDataState extends AuthStates {
  final UserModel? model;

  SuccessUserDataState(this.model);
}

class ErrorUserDataState extends AuthStates {
  final String? error;

  ErrorUserDataState(this.error);
}

//UPDATE USER DATA
class LoadingUpdateUserDateState extends AuthStates {}

class SuccessUpdateUserDateState extends AuthStates {}

class ErrorUpdateUserDateState extends AuthStates {
  final String? error;

  ErrorUpdateUserDateState(this.error);
}

//SIGN OUT
class LoadingSignOutState extends AuthStates {}

class SuccessSignOutState extends AuthStates {}

class ErrorSignOutState extends AuthStates {
  final String? error;

  ErrorSignOutState(this.error);
}

///login
class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final UserModel? loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AuthStates {
  final String? error;
  LoginErrorState(this.error);
}

//
class ChangePassLoadingState extends AuthStates {}

class ChangePassSuccessState extends AuthStates {}

class ChangePassErrorState extends AuthStates {
  final String? error;
  ChangePassErrorState(this.error);
}

//
class PassVisState extends AuthStates {}

///reg

class RegisterInitialState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {
  final UserModel? loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegPassVisState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String? error;
  RegisterErrorState(this.error);
}
