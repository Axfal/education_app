import 'package:education_app/resources/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NotesModel>('notes');
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
        ChangeNotifierProvider(create: (_) => MockTestProvider()),
        ChangeNotifierProvider(create: (_) => MockTestProvider()),
        ChangeNotifierProvider(create: (_) => PreviousTestProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        title: 'Education App',
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.home,
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
