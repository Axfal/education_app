import 'package:education_app/resources/exports.dart';

class MockTestProvider with ChangeNotifier {
  int _numberOfQuestions = 10;
  int get numberOfQuestions => _numberOfQuestions;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  int _incorrectAns = 0;
  int get incorrectAns => _incorrectAns;

  List<MockTestModel> _selectSubject = mockTextPhysicsQuestions;
  List<MockTestModel> get selectSubject => _selectSubject;

  List<bool> _showExplanation =
      List.generate(mockTextPhysicsQuestions.length, (index) => false);
  List<bool> get showExplanation => _showExplanation;

  final bool _explanationSwitch = false;
  bool get explanationSwitch => _explanationSwitch;

  bool _isNxtEnabled = false;
  bool get isNxtEnabled => _isNxtEnabled;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _isPrevEnabled = false;
  bool get isPrevEnabled => _isPrevEnabled;

  String? _selectedSubject;
  String? get selectedSubject => _selectedSubject;

  List<int?> _selectedOptions = List<int?>.filled(mockTextPhysicsQuestions.length, null);
  List<int?> get selectedOptions => _selectedOptions;

  List<bool> _isSubmitted = List<bool>.filled(mockTextPhysicsQuestions.length, true);
  List<bool> get isSubmitted => _isSubmitted;

  bool _isTestStarted = false;
  bool get isTestStarted => _isTestStarted;

  int _timeInSeconds = 30;
  int get timeInSeconds => _timeInSeconds;

  int _endTime = DateTime.now().millisecondsSinceEpoch + 10000;
  int get endTime => _endTime;

  bool _shouldNavigate = false;
  bool get shouldNavigate => _shouldNavigate;

  // late int _testDate;
  // int get testDate => _testDate;
  //
  // String getCurrentDate() {
  //   DateTime now = DateTime.now();
  //   return DateFormat('yyyy-MM-dd').format(now); // Format the current date
  // }

  void onChangeRadio(int index, int? value) {
    if (!_isSubmitted[index]) {
      _selectedOptions[index] = value;
      notifyListeners();
    }
  }

  navigate(BuildContext context) {
    if (_shouldNavigate) {
      Navigator.pushReplacementNamed(context, RoutesName.resultScreen,
          arguments: {
            'correctAns': _correctAns,
            'incorrectAns': _incorrectAns,
            'totalQuestion': _numberOfQuestions
          });
      // resetProvider();
    }
    notifyListeners();
  }

  void setNumberOfQuestion(double value) {
    _numberOfQuestions = value.toInt();
    if (kDebugMode) {
      print("_numberOfQuestions = $_numberOfQuestions");
    }
    notifyListeners();
  }

  void submitAnswer(context, int index) {
    if (_selectedOptions[index] != null) {
      _isSubmitted[index] = true;

      if (_selectedOptions[index] == _selectSubject?[index].correctIndex) {
        _correctAns++;
      } else {
        _incorrectAns++;
      }

      bool allSubmitted = _isSubmitted.every((submitted) => submitted == true);
      if (allSubmitted) {
        Future.microtask(() {
          Navigator.pushReplacementNamed(context, RoutesName.resultScreen, arguments: {
            'correctAns': _correctAns,
            'incorrectAns': _incorrectAns,
            'totalQuestion': _numberOfQuestions
          });
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an option before submitting!")),
      );
    }

    notifyListeners();
  }

  void setSelectedSubject(String? subject) {
    _selectedSubject = subject;
    switch (_selectedSubject) {
      case 'Physics':
        _selectSubject = mockTextPhysicsQuestions;
        break;
      case 'Chemistry':
        _selectSubject = mockTextChemistryQuestions;
        break;
      case 'Biology':
        _selectSubject = mockTextBiologyQuestions;
        break;
      case 'Analytical Reasoning':
        _selectSubject = mockTextAnalyticalReasonQuestions;
        break;
      default:
        _selectSubject = mockTextEnglishQuestions;
        break;
    }
    notifyListeners();
  }

  void restartTest() {
    resetProvider();
    notifyListeners();
  }

  void startTest() {
    _isTestStarted = true;
    _isPrevEnabled = false;
    _isNxtEnabled = true;
    _currentIndex = 0;
    _timeInSeconds = 30;
    _correctAns = 0;
    _incorrectAns = 0;
    _shouldNavigate = true;
    _isSubmitted = List<bool>.filled(_numberOfQuestions, false);
    _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;
    notifyListeners();
  }

  void resetProvider() {
    _correctAns = 0;
    _incorrectAns = 0;
    _isSubmitted = List<bool>.filled(_numberOfQuestions, false);
    _selectedSubject = null;
    _showExplanation =
        List.generate(mockTextPhysicsQuestions.length, (index) => false);
    _selectedOptions = List<int?>.filled(mockTextPhysicsQuestions.length, null);
    _isSubmitted = List<bool>.filled(mockTextPhysicsQuestions.length, true);
    _isTestStarted = false;
    _isNxtEnabled = false;
    _timeInSeconds = 30;
    _numberOfQuestions = 10;
    _isPrevEnabled = false;
    _currentIndex = 0;
    _shouldNavigate = false;
    _endTime = DateTime.now().millisecondsSinceEpoch + _timeInSeconds * 1000;
    notifyListeners();
  }

  void goToNext() {
    if (kDebugMode) {
      print("_currentIndex= $_currentIndex");
    }
    if (_currentIndex < (_numberOfQuestions - 1)) {
      _currentIndex += 1;
      _isPrevEnabled = true;
      if (_currentIndex == (_numberOfQuestions - 1)) {
        _isNxtEnabled = false;
      } else {
        _isNxtEnabled = true;
      }
    } else {
      _isNxtEnabled = false;
    }
    notifyListeners();
  }

  void goToPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _isNxtEnabled = true;
      if (_currentIndex == 0) {
        _isPrevEnabled = false;
      } else {
        _isPrevEnabled = true;
      }
    } else {
      _isPrevEnabled = false;
    }
    notifyListeners();
  }

  void toggleExplanationSwitch(value) {
    if (_selectedOptions[_currentIndex] != null &&
        _isSubmitted[_currentIndex]) {
      _showExplanation[_currentIndex] = value;
    }
    notifyListeners();
  }
}
