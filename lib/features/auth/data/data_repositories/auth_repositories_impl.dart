import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/error_hangling/LoginErrorHandler.dart';
import 'package:ecommerce_app/core/error_hangling/SignErrorHandler.dart';
import 'package:ecommerce_app/features/auth/data/data_model/login_response/LoginResponse.dart';
import 'package:ecommerce_app/features/auth/data/data_repositories/auth_repositories.dart';
import 'package:ecommerce_app/features/auth/data/data_source/auth_data_source.dart';

import '../../../../core/services/storage_services.dart';
import '../data_model/signUp_response/signUpResponse.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  AuthDataSource dataSource;

  AuthRepositoriesImpl(this.dataSource);

  @override
  Future<LoginResponse> login(
      {required String email, required String password}) async {
    try {
      var response = await dataSource.login(email: email, password: password);
      if (response.statusCode == 200) {
        LoginResponse data = LoginResponse.fromJson(response.data);
        await StorageServices.saveToken(data.token!);
        return data;
      } else {
        var errorMessage = LoginErrorHandler.fromJson(response.data);
        throw errorMessage.message ?? "";
      }
    } on DioException catch (error, s) {
      print(s);
      var errorMessage = LoginErrorHandler.fromJson(error.response?.data);
      throw errorMessage.message ?? "";
    } catch (error, s) {
      print(error);
      print(s);
      rethrow;
    }
  }


  @override
  Future<SignUpResponse> signUp(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    try {
      var response = await dataSource.signUp(
          email: email, password: password, name: name, phone: phone);
      if (response.statusCode == 201) {
        SignUpResponse data = SignUpResponse.fromJson(response.data);
        await StorageServices.saveToken(data.token!);
        return data;
      } else {
        var errorMessage = SignUpErrorHandler.fromJson(response.data);
        throw errorMessage.message ?? "";
      }
    } on DioException catch (error, s) {
      print(s);
      var errorMessage = SignUpErrorHandler.fromJson(error.response?.data);
      throw errorMessage.message ?? "";
    } catch (error, s) {
      print(error);
      print(s);
      rethrow;
    }
  }
}
