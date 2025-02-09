// import 'package:education_app/resources/exports.dart';
//
// class MockTestProvider with ChangeNotifier {
//   List<bool> _showExplanation =
//       List.generate(mockTextPhysicsQuestions.length, (index) => false);
//   List<bool> get showExplanation => _showExplanation;
//
//   final bool _explanationSwitch = false;
//   bool get explanationSwitch => _explanationSwitch;
//
//   bool _isNxtEnabled = false;
//   bool get isNxtEnabled => _isNxtEnabled;
//
//   int _currentIndex = 0;
//   int get currentIndex => _currentIndex;
//
//   bool _isPrevEnabled = false;
//   bool get isPrevEnabled => _isPrevEnabled;
//
//   List<int?> _selectedOptions =
//       List<int?>.filled(mockTextPhysicsQuestions.length, null);
//   List<int?> get selectedOptions => _selectedOptions;
//
//   List<bool> _isSubmitted =
//       List<bool>.filled(mockTextPhysicsQuestions.length, true);
//   List<bool> get isSubmitted => _isSubmitted;
//
//   bool _isTestStarted = false;
//   bool get isTestStarted => _isTestStarted;
//
//   int _timeInSeconds = 30;
//   int get timeInSeconds => _timeInSeconds;
//
//   int _endTime = DateTime.now().millisecondsSinceEpoch + 10000;
//   int get endTime => _endTime;
//
//   bool _shouldNavigate = false;
//   bool get shouldNavigate => _shouldNavigate;
//
//   void onChangeRadio(int index, int? value) {
//     if (!_isSubmitted[index]) {
//       _selectedOptions[index] = value;
//       notifyListeners();
//     }
//   }
//
//   navigate(BuildContext context) {
//     if (_shouldNavigate) {
//       resetProvider();
//       Navigator.pushReplacementNamed(context, RoutesName.resultScreen);
//     }
//     notifyListeners();
//   }
//
//   void submitAnswer(int index) {
//     if (_selectedOptions[_currentIndex] != null) {
//       _isSubmitted[index] = true;
//     }
//
//     notifyListeners();
//   }
//
//   void restartTest() {
//     _selectedOptions = List<int?>.filled(mockTextPhysicsQuestions.length, null);
//     _isSubmitted = List<bool>.filled(mockTextPhysicsQuestions.length, true);
//     _showExplanation =
//         List.generate(mockTextPhysicsQuestions.length, (index) => false);
//     _isTestStarted = false;
//     _shouldNavigate = false;
//     _timeInSeconds = 30;
//     _currentIndex = 0;
//     _isPrevEnabled = false;
//     _isNxtEnabled = false;
//     notifyListeners();
//   }
//
//   void startTest() {
//     _isTestStarted = true;
//     _isPrevEnabled = false;
//     _isNxtEnabled = true;
//     _currentIndex = 0;
//     _timeInSeconds = 30;
//     _shouldNavigate = true;
//     _isSubmitted = List<bool>.filled(mockTextPhysicsQuestions.length, false);
//     _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;
//     notifyListeners();
//   }
//
//   void resetProvider() {
//     _showExplanation =
//         List.generate(mockTextPhysicsQuestions.length, (index) => false);
//     _selectedOptions = List<int?>.filled(mockTextPhysicsQuestions.length, null);
//     _isSubmitted = List<bool>.filled(mockTextPhysicsQuestions.length, true);
//     _isTestStarted = false;
//     _isNxtEnabled = false;
//     _timeInSeconds = 30;
//     _isPrevEnabled = false;
//     _currentIndex = 0;
//     _shouldNavigate = false;
//     _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;
//     notifyListeners();
//   }
//
//   void goToNext() {
//     if (_currentIndex < mockTextPhysicsQuestions.length - 1) {
//       _currentIndex++;
//       _isPrevEnabled = true;
//       if (_currentIndex == mockTextPhysicsQuestions.length - 1) {
//         _isNxtEnabled = false;
//       } else {
//         _isNxtEnabled = true;
//       }
//     } else {
//       _isNxtEnabled = false;
//     }
//     notifyListeners();
//   }
//
//   void goToPrevious() {
//     if (_currentIndex > 0) {
//       _currentIndex--;
//       _isNxtEnabled = true;
//       if (_currentIndex == 0) {
//         _isPrevEnabled = false;
//       } else {
//         _isPrevEnabled = true;
//       }
//     } else {
//       _isPrevEnabled = false;
//     }
//     notifyListeners();
//   }
//
//   void toggleExplanationSwitch(value) {
//     if (_selectedOptions[_currentIndex] != null &&
//         _isSubmitted[_currentIndex]) {
//       _showExplanation[_currentIndex] = value;
//     }
//     notifyListeners();
//   }
// }
