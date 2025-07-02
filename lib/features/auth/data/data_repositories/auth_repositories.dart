import 'package:ecommerce_app/features/auth/data/data_model/login_response/LoginResponse.dart';
import 'package:ecommerce_app/features/auth/data/data_model/signUp_response/signUpResponse.dart';

abstract class AuthRepositories {
  Future<LoginResponse> login(
      {required String email, required String password});

  Future<SignUpResponse> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  });
}

