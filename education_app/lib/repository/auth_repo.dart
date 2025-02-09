import 'dart:convert';

import 'package:education_app/resources/exports.dart';


class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signIn, data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signUp, data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<TestSubjectModel?> setSubject() async {
    try {
      print("Fetching API...");

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.fetchTest);

      print("Raw API Response: $response"); // Debugging

      if (response is Map<String, dynamic>) {
        return TestSubjectModel.fromJson(response);
      } else {
        print("Unexpected response type: ${response.runtimeType}");
        return null;
      }
    } catch (error) {
      print("Error in API: $error");
      return null;
    }
  }


}
