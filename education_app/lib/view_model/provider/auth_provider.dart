import 'package:education_app/resources/exports.dart';

class AuthProvider with ChangeNotifier {
  final _authRepository = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;
  TestSubjectModel? _subjectList;
  TestSubjectModel? get subjectList => _subjectList;
  Future<void> subjectsList() async {
    try {
      print("Fetching subjects...");
      final response = await _authRepository.setSubject();

      if (response != null) {
        print("Response received: ${response.toJson()}"); // Debugging
        if (response.success == true && response.data != null) {
          _subjectList = response; // Directly assign the response
          print("Subjects list updated successfully: ${_subjectList!.data!.length} subjects found");
        } else {
          print("API Response indicates failure: ${response.success}");
        }
      } else {
        print("Error: Response is null.");
      }
    } catch (error) {
      print("Error in subjectsList(): $error");
    }
    notifyListeners();
  }

  Future<void> signIn(context, dynamic data) async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _authRepository.loginApi(data);

      if (response != null && response is Map<String, dynamic>) {
        if (response['success'] == true) {
          Navigator.pushReplacementNamed(context, RoutesName.home);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('SignIn Successfully'),
                backgroundColor: AppColors.primaryColor),
          );
        } else {
          if (kDebugMode) {
            print(response);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'SignIn Failed: ${response['message'] ?? "response => -----$response"}'),
                backgroundColor: Colors.red),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Invalid API response'),
              backgroundColor: Colors.red),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error: ${error.toString()}'),
            backgroundColor: Colors.red),
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(context, data) async {
    _loading = true;
    notifyListeners();
    try {
      final response = await _authRepository.signUpApi(data);
      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('success') && response['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Signup Successful'),
                backgroundColor: AppColors.primaryColor),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Signup Failed: ${response['error']}'),
                backgroundColor: Colors.red),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Invalid API Response Format'),
              backgroundColor: Colors.red),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error: ${error.toString()}'),
            backgroundColor: Colors.red),
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
