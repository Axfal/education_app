import 'package:education_app/resources/exports.dart';

import '../model/create_mock_test_model.dart';

class CreateMockTestRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<CreateMockTestModel> createMockTest(Map<String, dynamic> data) async {
    try {
      print("🌐 Making API request to: ${AppUrl.createMockTest}");
      print("📦 Request data: $data");

      final response =
          await _apiServices.getPostApiResponse(AppUrl.createMockTest, data);

      print("📥 Raw API Response: $response");

      if (response == null) {
        throw Exception("Null response from API");
      }

      final mockTestModel = CreateMockTestModel.fromJson(response);

      print(
          "✨ Parsed questions count: ${mockTestModel.questions?.length ?? 0}");

      return mockTestModel;
    } catch (error) {
      print("💥 API Error: $error");
      rethrow;
    }
  }
}
