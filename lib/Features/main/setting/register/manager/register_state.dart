import '../model/user_model.dart';

abstract class RegisterViewState {}

class InitializeRegisterState extends RegisterViewState {}

class ChangeCheckState extends RegisterViewState {}

class GetNameDataBaseSuccessState extends RegisterViewState {}

class GetNameDataBaseLoadingState extends RegisterViewState {}

class GetNameDataBaseErrorState extends RegisterViewState {}

class LoginSuccessState extends RegisterViewState {
  UserModel data;
  LoginSuccessState(this.data);
}

class LoginLoadingState extends RegisterViewState {}

class LoginErrorState extends RegisterViewState {}

class CheckLoginSuccessState extends RegisterViewState {}

class CheckLoginLoadingState extends RegisterViewState {}

class CheckLoginErrorState extends RegisterViewState {}

class ChangeCheckBoxState extends RegisterViewState {}

class ChangeIconPasswordSuccess extends RegisterViewState {}

class CheckActivationCodeLoading extends RegisterViewState {}

class CheckActivationCodeSuccess extends RegisterViewState {}

class CheckActivationCodeError extends RegisterViewState {}

class DeactivateCodeLoading extends RegisterViewState {}

class DeactivateCodeSuccess extends RegisterViewState {
  final String message;

  DeactivateCodeSuccess(this.message);
}

class DeactivateCodeError extends RegisterViewState {
  final String error;

  DeactivateCodeError(this.error);
}

class CheckDeviceActivateLoading extends RegisterViewState {}

class CheckDeviceActivateSuccess extends RegisterViewState {
  final bool isActive;
  CheckDeviceActivateSuccess(this.isActive);
}

class CheckDeviceActivateError extends RegisterViewState {
  final bool isActive;
  CheckDeviceActivateError(this.isActive);
}
