
sealed class AuthStates {}

class InitState extends AuthStates{}

class LoginLoadingState extends AuthStates{}

class LoginSuccessState extends AuthStates{
  String? successMessage;
  LoginSuccessState({this.successMessage});

}

class LoginErrorState extends AuthStates{
  String? errorMessage;
  LoginErrorState({this.errorMessage});
}





class SignUpLoadingState extends AuthStates{}

class SignUpSuccessState extends AuthStates{
  String? successMessage;
  SignUpSuccessState({this.successMessage});

}

class SignUpErrorState extends AuthStates{
  String? errorMessage;
  SignUpErrorState({this.errorMessage});
}