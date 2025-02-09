import 'package:education_app/resources/exports.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignupScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case RoutesName.course:
        return MaterialPageRoute(builder: (context) => CourseScreen());

      case RoutesName.setting:
        return MaterialPageRoute(builder: (context) => SettingsScreen());

      case RoutesName.mockTest:
        return MaterialPageRoute(builder: (context) => MockTestScreen());

      case RoutesName.profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());

      case RoutesName.noteScreen:
        return MaterialPageRoute(builder: (context) => NoteScreen());

      case RoutesName.createMockTest:
        return MaterialPageRoute(builder: (context) => CreateMockTest());

      case RoutesName.previousTestScreen:
        return MaterialPageRoute(builder: (context) => PreviousTestScreen());

      case RoutesName.resultScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final correctAnswer = args['correctAns'] ?? 0;
        final incorrectAnswer = args['incorrectAns'] ?? 0;
        final totalQuestion = args['totalQuestion'] ?? 0;
        return MaterialPageRoute(
            builder: (context) => ResultScreen(
              correctAns: correctAnswer,
              incorrectAns: incorrectAnswer,
              totalQues: totalQuestion,
            ));

      case RoutesName.chapterScreen:
        return MaterialPageRoute(builder: (context) => ChaptersScreen());

      case RoutesName.questionScreen:
        return MaterialPageRoute(builder: (context) => QuestionScreen());

      case RoutesName.createdMockTestScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final numberOfQuestions = args['number_of_questions'] as double? ?? 1.0;
        final testMode = args['test_mode'] as bool? ?? false;
        final subjectMode = args['subject_mode'] as String? ?? 'default';
        final questionMode = args['question_mode'] as String? ?? 'default';

        return MaterialPageRoute(
          builder: (context) => CreatedMockTestScreen(
            numberOfQuestions: numberOfQuestions,
            testMode: testMode,
            subjectMode: subjectMode,
            questionMode: questionMode,
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }
  }
}
