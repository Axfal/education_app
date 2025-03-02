import 'package:flutter/material.dart';
import '../../main.dart';
import '../../model/feedback_model.dart';
import '../../repository/feedback_repo.dart';

class FeedbackProvider with ChangeNotifier {
  final FeedbackRepository _feedbackRepository = FeedbackRepository();
  FeedbackModel? _feedbackModel;

  FeedbackModel? get feedback => _feedbackModel;

  Future<void> giveFeedback(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      final response = await _feedbackRepository.giveFeedback(data);
      _feedbackModel = FeedbackModel.fromJson(response as Map<String, dynamic>);

      if (!context.mounted) {
        return;
      }

      String message =
          _feedbackModel!.message ?? 'Feedback submitted successfully';
      Color color = _feedbackModel!.success == true ? Colors.green : Colors.red;

      _showSnackBar(message, color);

      notifyListeners(); // Notify listeners if needed
    } catch (e) {
      if (!context.mounted) return;
      _showSnackBar('An error occurred: $e', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    final scaffoldMessenger = GlobalVariables.scaffoldMessengerKey.currentState;
    if (scaffoldMessenger != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(message), backgroundColor: color),
      );
    } else {
      debugPrint("ScaffoldMessenger not found!");
    }
  }
}
