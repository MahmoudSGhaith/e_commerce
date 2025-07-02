import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/network_services.dart';
import 'package:ecommerce_app/features/auth/data/data_source/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  NetworkServices networkServices;

  AuthDataSourceImpl(this.networkServices);

  @override
  Future<Response> login({required String email, required String password}) {
    return networkServices.dio
        .post("auth/signin", data: {"email": email, "password": password});
  }

  @override
  Future<Response> signUp(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    return networkServices.dio.post("auth/signup", data: {
      "name": name,
      "email" : email,
      "password": password,
      "rePassword" : password,
      "phone": phone
    });
  }
}
