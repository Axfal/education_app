import 'package:education_app/resources/exports.dart';
import 'model/previous_test_report_model.dart';
import 'model/user_session_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  Hive.registerAdapter(UserSessionModelAdapter());
  Hive.registerAdapter(PreviousTestReportModelAdapter());
  await Hive.openBox<PreviousTestReportModel>('previousTests');
  await Hive.openBox<NotesModel>('notes');
  await Hive.openBox<UserSessionModel>('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigatorBarProvider()),
        ChangeNotifierProvider(create: (_) => PreviousTestProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
        ChangeNotifierProvider(create: (_) => ChapterProvider()),
        ChangeNotifierProvider(create: (_) => MockTestProvider()),
        // ChangeNotifierProvider(create: (_) => MockTestsProvider()),
        ChangeNotifierProvider(create: (_) => QuestionsProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
        ChangeNotifierProvider(
          create: (_) => CreateMockTestProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: GlobalVariables.scaffoldMessengerKey,
        title: 'Education App',
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class GlobalVariables {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
