import 'dart:convert';
import 'dart:io';
import 'package:education_app/resources/exports.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    try {
      if (kDebugMode) {
        print("URL: $url");
      }
      if (kDebugMode) {
        print("Request Data: ${jsonEncode(data)}");
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 10));

      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Response Body: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (error) {
      if (kDebugMode) {
        print("API Error: $error");
      }
      throw Exception("API error: $error");
    }
  }



  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            "Error Occurred While Communicating With Server with status code ${response.statusCode}");
    }
  }
}
