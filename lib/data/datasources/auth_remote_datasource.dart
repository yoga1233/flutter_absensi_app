import 'dart:convert';

import 'package:altius_absensi_app/core/constants/variables.dart';
import 'package:altius_absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:altius_absensi_app/data/models/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final uri = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('failed to login');
    }
  }

  //logout

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}'
    });
    if (response.statusCode == 200) {
      return right('Logout Success');
    } else {
      return left('Failed to logout');
    }
  }
}
