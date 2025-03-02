import 'package:education_app/resources/exports.dart';

class QuestionsProvider with ChangeNotifier {
  final QuestionRepository _mockTestRepo = QuestionRepository();

  MockTestModel? _questions;

  MockTestModel? get questions => _questions;

  String? _subject;
  String? get subject => _subject;

  List<Question> _questionList = [];
  List<Question> get questionList => _questionList;

  final Map<String, int> correctOptionMapping = {
    "a": 0,
    "b": 1,
    "c": 2,
    "d": 3,
  };

  int? _numberOfQuestions;
  int? get numberOfQuestions => _numberOfQuestions;

  List<bool> _isSubmitted = [];
  List<bool> get isSubmitted => _isSubmitted;

  List<bool> _isChecked = [];
  List<bool> get isChecked => _isChecked;

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

  Future<void> fetchQuestions(
      BuildContext context, int subjectId, int chapterId) async {
    try {
      _loading = true;
      notifyListeners();

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userSession?.userId ?? 0;
      Map<String, dynamic> data =
          authProvider.userSession?.userType == "premium"
              ? {
                  'user_id': userId,
                  "subject_id": subjectId,
                  "chapter_id": chapterId
                }
              : {'user_id': userId};

      final response = await _mockTestRepo.fetchQuestions(data);

      if (response.success == true && response.questions.isNotEmpty) {
        _questions = response;
        _questionList = _questions!.questions;
        _numberOfQuestions = _questionList.length;
        _selectedOptions = List<int?>.filled(_numberOfQuestions!, null);
        _isChecked = List<bool>.filled(_numberOfQuestions!, false);
        _isSubmitted = List<bool>.filled(_numberOfQuestions!, false);
        _showExplanation = List<bool>.filled(_numberOfQuestions!, false);
      } else {
        _questions = null;
        _questionList = [];
        _numberOfQuestions = 0;
      }
    } catch (error) {
      debugPrint("Error fetching questions: $error");
      _questions = null;
      _questionList = [];
      _numberOfQuestions = 0;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void restartTest() {
    resetProvider();
    notifyListeners();
  }

  void checkBox(int index, bool value) {
    if (index >= 0 && index < _isChecked.length) {
      _isChecked[index] = value;
      notifyListeners();
    }
  }

  void startTest() {
    if (_questionList.isEmpty) {
      if (kDebugMode) {
        print("Error: Cannot start test, question list is empty!");
      }
      return;
    }

    _isTestStarted = true;
    _isPrevEnabled = false;
    _isNxtEnabled = true;
    _currentIndex = 0;
    _correctAns = 0;
    _incorrectAns = 0;
    _shouldNavigate = true;

    _isSubmitted = List<bool>.filled(_questionList.length, false);
    _selectedOptions = List<int?>.filled(_questionList.length, null);
    _showExplanation = List.generate(_questionList.length, (_) => false);

    notifyListeners();
  }

  void resetProvider() {
    _correctAns = 0;
    _incorrectAns = 0;

    if (_numberOfQuestions != null && _numberOfQuestions! > 0) {
      _selectedOptions = List<int?>.filled(_numberOfQuestions!, null);
      _isChecked = List<bool>.filled(_numberOfQuestions!, false);
      _showExplanation = List<bool>.filled(_numberOfQuestions!, false);
    }

    _isTestStarted = false;
    _isNxtEnabled = false;
    _isPrevEnabled = false;
    _currentIndex = 0;
    _shouldNavigate = false;

    notifyListeners();
  }

  void toggleExplanationSwitch(int index, bool value) {
    if (index >= 0 && index < _showExplanation.length) {
      _showExplanation[index] = value;
      notifyListeners();
    }
  }
}
