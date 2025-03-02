// import 'package:education_app/model/create_mock_test_model.dart';
// import 'package:education_app/repository/create_mock_test_repo.dart';
// import 'package:education_app/resources/exports.dart';
//
// class CreateMockTestProvider with ChangeNotifier {
//   CreateMockTestRepo createMockTestRepo = CreateMockTestRepo();
//
//   CreateMockTestModel? _createMockTestModel;
//   CreateMockTestModel? get createMockTestModel => _createMockTestModel;
//
//   Future<void> getQuestions(BuildContext context, Map<String, dynamic> data) async {
//     try {
//       final response = await createMockTestRepo.createMockTest(data);
//       _createMockTestModel = CreateMockTestModel.fromJson(response as Map<String, dynamic>);
//
//       notifyListeners(); // Notify UI about the state change
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
