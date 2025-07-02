import 'package:ecommerce_app/features/auth/data/data_repositories/auth_repositories.dart';
import 'package:ecommerce_app/features/auth/presentation/manger/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepositories) : super(InitState());
  AuthRepositories authRepositories;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  static AuthCubit get(context) => BlocProvider.of(context);

  /// ✅ تسجيل الدخول
  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      var data = await authRepositories.login(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(LoginSuccessState(successMessage: data.message));
    } catch (error) {
      emit(LoginErrorState(errorMessage: error.toString()));
    }
  }

  /// ✅ التسجيل
  Future<void> signUp() async {
    emit(SignUpLoadingState());
    try {
      var data = await authRepositories.signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      );
      emit(SignUpSuccessState(successMessage: data.message));
    } catch (error) {
      emit(SignUpErrorState(errorMessage: error.toString()));
    }
  }
}

