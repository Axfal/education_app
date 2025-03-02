// ignore_for_file: avoid_print

import 'package:education_app/resources/exports.dart';
import '../../model/create_mock_test_model.dart';
import '../../repository/create_mock_test_repo.dart';

// class MockTestsProvider with ChangeNotifier {
//   int _numberOfQuestions = 1;
//   int get numberOfQuestions => _numberOfQuestions;
//
//   int _correctAns = 0;
//   int get correctAns => _correctAns;
//
//   int _incorrectAns = 0;
//   int get incorrectAns => _incorrectAns;
//
//   List<MockTestsModel> _selectSubject = mockTextPhysicsQuestions;
//   List<MockTestsModel> get selectSubject => _selectSubject;
//
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
//   String? _selectedSubject;
//   String? get selectedSubject => _selectedSubject;
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
//       Navigator.pushReplacementNamed(context, RoutesName.resultScreen,
//           arguments: {
//             'correctAns': _correctAns,
//             'incorrectAns': _incorrectAns,
//             'totalQuestion': _numberOfQuestions
//           });
//       // resetProvider();
//     }
//     notifyListeners();
//   }
//
//   void setNumberOfQuestion(double value) {
//     _numberOfQuestions = value.toInt();
//     if (kDebugMode) {
//       print("_numberOfQuestions = $_numberOfQuestions");
//     }
//     notifyListeners();
//   }
//
//   void submitAnswer(context, int index) {
//     if (_selectedOptions[index] != null) {
//       _isSubmitted[index] = true;
//
//       if (_selectedOptions[index] == _selectSubject[index].correctIndex) {
//         _correctAns++;
//       } else {
//         _incorrectAns++;
//       }
//
//       bool allSubmitted = _isSubmitted.every((submitted) => submitted == true);
//       if (allSubmitted) {
//         Future.microtask(() {
//           Navigator.pushReplacementNamed(context, RoutesName.resultScreen,
//               arguments: {
//                 'correctAns': _correctAns,
//                 'incorrectAns': _incorrectAns,
//                 'totalQuestion': _numberOfQuestions
//               });
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Please select an option before submitting!")),
//       );
//     }
//
//     notifyListeners();
//   }
//
//   void setSelectedSubject(String? subject) {
//     _selectedSubject = subject;
//     switch (_selectedSubject) {
//       case 'Physics':
//         _selectSubject = mockTextPhysicsQuestions;
//         break;
//       case 'Chemistry':
//         _selectSubject = mockTextChemistryQuestions;
//         break;
//       case 'Biology':
//         _selectSubject = mockTextBiologyQuestions;
//         break;
//       case 'Analytical Reasoning':
//         _selectSubject = mockTextAnalyticalReasonQuestions;
//         break;
//       default:
//         _selectSubject = mockTextEnglishQuestions;
//         break;
//     }
//     notifyListeners();
//   }
//
//   void restartTest() {
//     resetProvider();
//     notifyListeners();
//   }
//
//   void startTest() {
//     if (_selectSubject.isEmpty) {
//       print("Cannot start test: No questions available");
//       return;
//     }
//
//     _isTestStarted = true;
//     _isPrevEnabled = false;
//     _isNxtEnabled = _selectSubject.length > 1;
//     _currentIndex = 0;
//     _correctAns = 0;
//     _incorrectAns = 0;
//     _shouldNavigate = true;
//     _timeInSeconds = 30;
//
//     // Make sure these arrays are properly initialized
//     _isSubmitted = List<bool>.filled(_selectSubject.length, false);
//     _selectedOptions = List<int?>.filled(_selectSubject.length, null);
//     _showExplanation = List<bool>.filled(_selectSubject.length, false);
//
//     _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;
//
//     notifyListeners();
//   }
//
//   void resetProvider() {
//     _correctAns = 0;
//     _incorrectAns = 0;
//     _isSubmitted = List<bool>.filled(_numberOfQuestions, false);
//     _selectedSubject = null;
//     _showExplanation =
//         List.generate(mockTextPhysicsQuestions.length, (index) => false);
//     _selectedOptions = List<int?>.filled(mockTextPhysicsQuestions.length, null);
//     _isSubmitted = List<bool>.filled(mockTextPhysicsQuestions.length, true);
//     _isTestStarted = false;
//     _isNxtEnabled = false;
//     _timeInSeconds = 30;
//     _numberOfQuestions = 10;
//     _isPrevEnabled = false;
//     _currentIndex = 0;
//     _shouldNavigate = false;
//     _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;
//     notifyListeners();
//   }
//
//   void goToNext() {
//     if (kDebugMode) {
//       print("_currentIndex= $_currentIndex");
//     }
//     if (_currentIndex < (_numberOfQuestions - 1)) {
//       _currentIndex += 1;
//       _isPrevEnabled = true;
//       if (_currentIndex == (_numberOfQuestions - 1)) {
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

class CreateMockTestProvider with ChangeNotifier {
  CreateMockTestRepo createMockTestRepo = CreateMockTestRepo();

  List<Questions> _questionList = [];
  List<Questions> get questionList => _questionList;

  int _timeInSeconds = 30;
  int get timeInSeconds => _timeInSeconds;

  int _endTime = DateTime.now().millisecondsSinceEpoch + 10000;
  int get endTime => _endTime;

  final Map<String, int> correctOptionMapping = {
    "a": 0,
    "b": 1,
    "c": 2,
    "d": 3
  };

  int _numberOfQuestions = 1;
  int get numberOfQuestions => _numberOfQuestions;

  List<bool> _isSubmitted = [];
  List<bool> get isSubmitted => _isSubmitted;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  int _incorrectAns = 0;
  int get incorrectAns => _incorrectAns;

  bool _loading = false;
  bool get loading => _loading;

  bool _isTestStarted = false;
  bool get isTestStarted => _isTestStarted;

  List<int?> _selectedOptions = [];
  List<int?> get selectedOptions => _selectedOptions;

  List<bool> _showExplanation = [];
  List<bool> get showExplanation => _showExplanation;

  final bool _explanationSwitch = false;
  bool get explanationSwitch => _explanationSwitch;

  bool _isNxtEnabled = false;
  bool get isNxtEnabled => _isNxtEnabled;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _isPrevEnabled = false;
  bool get isPrevEnabled => _isPrevEnabled;

  bool _shouldNavigate = false;
  bool get shouldNavigate => _shouldNavigate;

  CreateMockTestModel? _createMockTestModel;
  CreateMockTestModel? get createMockTestModel => _createMockTestModel;

  void setNumberOfQuestion(double value) {
    _numberOfQuestions = value.toInt();
    if (kDebugMode) {
      print("_numberOfQuestions = $_numberOfQuestions");
    }
    notifyListeners();
  }

  Future<void> getQuestions(
      BuildContext context, Map<String, dynamic> data) async {
    _loading = true;
    notifyListeners();

    try {
      final response = await createMockTestRepo.createMockTest(data);
      print("Full API Response: $response");

      _createMockTestModel = response;

      if (_createMockTestModel?.success == true &&
          _createMockTestModel!.questions != null) {
        _questionList = _createMockTestModel!.questions!;
        _numberOfQuestions = _questionList.length;

        // Initialize arrays with the correct length
        _isSubmitted = List<bool>.filled(_questionList.length, false);
        _selectedOptions = List<int?>.filled(_questionList.length, null);
        _showExplanation = List<bool>.filled(_questionList.length, false);

        notifyListeners();
        print("Questions Fetched: ${_questionList.length}");
      } else {
        print("No questions received from API.");
        _questionList = [];
        _numberOfQuestions = 0;
      }
    } catch (error) {
      print("❌ Error fetching questions: $error");
      _questionList = [];
      _numberOfQuestions = 0;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void goBack() {
    restartTest();
    notifyListeners();
  }

  void onChangeRadio(int index, int? value) {
    if (_isSubmitted.isNotEmpty &&
        index < _isSubmitted.length &&
        !_isSubmitted[index]) {
      if (_selectedOptions.isNotEmpty && index < _selectedOptions.length) {
        _selectedOptions[index] = value;
      }
      notifyListeners();
    }
  }

  navigate(BuildContext context) {
    if (_shouldNavigate) {
      _isTestStarted = false;
      // final _provider = Provider.of<ChapterProvider>(context,listen: false);
      // _subject = _provider.subject;
      Navigator.pushReplacementNamed(context, RoutesName.resultScreen,
          arguments: {
            'subject': 'Created Mock Test',
            'correctAns': _correctAns,
            'incorrectAns': _incorrectAns,
            'totalQuestion': _numberOfQuestions
          });
    }
    notifyListeners();
  }

  void submitAnswer(BuildContext context, int index) {
    if (_selectedOptions.isNotEmpty &&
        index < _selectedOptions.length &&
        _selectedOptions[index] != null) {
      if (_isSubmitted.isNotEmpty && index < _isSubmitted.length) {
        _isSubmitted[index] = true;
      }

      if (_questionList.isNotEmpty && index < _questionList.length) {
        String correctAnswerKey =
            _questionList[index].correctAnswer!.toLowerCase();
        int? correctAnswerIndex = correctOptionMapping[correctAnswerKey];

        if (_selectedOptions[index] == correctAnswerIndex) {
          _correctAns++;
        } else {
          _incorrectAns++;
        }
      }

      bool allSubmitted = _isSubmitted.every((submitted) => submitted == true);

      if (allSubmitted) {
        Future.microtask(() {
          Navigator.pushReplacementNamed(
            context,
            RoutesName.resultScreen,
            arguments: {
              'correctAns': _correctAns,
              'incorrectAns': _incorrectAns,
              'totalQuestion': _numberOfQuestions
            },
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an option before submitting!"),
        ),
      );
    }

    notifyListeners();
  }

  void restartTest() {
    resetProvider();
    notifyListeners();
  }

  void startTest() {
    if (_questionList.isEmpty) {
      print("Cannot start test: No questions available");
      return;
    }

    _isTestStarted = true;
    _isPrevEnabled = false;
    _isNxtEnabled = _questionList.length > 1;
    _currentIndex = 0;
    _correctAns = 0;
    _incorrectAns = 0;
    _shouldNavigate = true;
    _timeInSeconds = 30;

    // Initialize all arrays with the correct length
    _isSubmitted = List<bool>.filled(_questionList.length, false);
    _selectedOptions = List<int?>.filled(_questionList.length, null);
    _showExplanation = List<bool>.filled(_questionList.length, false);

    _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;
    notifyListeners();
  }

  void resetProvider() {
    _correctAns = 0;
    _incorrectAns = 0;

    if (_questionList.isNotEmpty) {
      _isSubmitted = List<bool>.filled(_questionList.length, false);
      _selectedOptions = List<int?>.filled(_questionList.length, null);
      _showExplanation = List<bool>.filled(_questionList.length, false);
    }

    _isTestStarted = false;
    _isNxtEnabled = false;
    _numberOfQuestions = _questionList.length;
    _isPrevEnabled = false;
    _currentIndex = 0;
    _shouldNavigate = false;
    _timeInSeconds = 30;
    _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;

    notifyListeners();
  }

  void goToNext() {
    if (_currentIndex < (_questionList.length - 1)) {
      _currentIndex++;
      _isPrevEnabled = true;
      _isNxtEnabled = _currentIndex < (_questionList.length - 1);
    } else {
      _isNxtEnabled = false;
    }
    notifyListeners();
  }

  void goToPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _isNxtEnabled = true;
      _isPrevEnabled = _currentIndex > 0;
    } else {
      _isPrevEnabled = false;
    }
    notifyListeners();
  }

  void toggleExplanationSwitch(bool value) {
    if (_selectedOptions.isNotEmpty &&
        _currentIndex < _selectedOptions.length &&
        _selectedOptions[_currentIndex] != null &&
        _isSubmitted.isNotEmpty &&
        _currentIndex < _isSubmitted.length &&
        _isSubmitted[_currentIndex]) {
      _showExplanation[_currentIndex] = value;
    }
    notifyListeners();
  }
}
