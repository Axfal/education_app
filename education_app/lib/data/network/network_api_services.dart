import 'dart:async';
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
    } on TimeoutException {
      throw FetchDataException("Request Timed Out. Try Again.");
    }

    return responseJson;
  }
  @override
  Future<dynamic> getPostMultipartRequestApiResponse(String url, dynamic data) async {
    try {
      if (kDebugMode) {
        print("Requesting API...");
        print("URL: $url");
        print("Request Data: $data");
      }

      if (data is! Map<String, dynamic>) {
        throw Exception("Invalid data type. Expected Map<String, dynamic>.");
      }

      var request = http.MultipartRequest("POST", Uri.parse(url));

      // Convert all values to String before adding to request
      data.forEach((key, value) {
        request.fields[key] = value.toString(); // ✅ Convert to String
      });

      request.headers['Accept'] = 'application/json';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      throw FetchDataException("API Timeout: The request took too long!");
    } catch (error) {
      if (kDebugMode) {
        print("API Error: $error");
      }
      throw Exception("API error: ${error.toString()}");
    }
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    try {
      if (kDebugMode) {
        print("Requesting API...");
        print("URL: $url");
        print("Request Data: ${jsonEncode(data)}");
      }

      final response = await http
          .post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      )
          .timeout(const Duration(seconds: 20)); // Increased timeout

      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}") ;
      }

      return returnResponse(response); // Use response handler
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      throw FetchDataException("API Timeout: The request took too long!");
    } catch (error) {
      if (kDebugMode) {
        print("API Error: $error");
      }
      throw Exception("API error: ${error.toString()}");
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw FetchDataException("API Not Found: ${response.body}");
      case 500:
      default:
        throw FetchDataException(
            "Server Error: ${response.statusCode}, ${response.body}");
    }
  }
}
