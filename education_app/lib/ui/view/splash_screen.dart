import '../../resources/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bookController;

  @override
  void initState() {
    super.initState();
    _bookController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _bookController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.primaryColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Icons8.book,
                width: 100,
                height: 100,
                controller: _bookController,
                onLoaded: (composition) {
                  _bookController.duration = composition.duration;
                },
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: 300.0,
                child: DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  child: Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Learn Anytime, Anywhere'),
                        TyperAnimatedText('Learning unlocks potential'),
                        TyperAnimatedText('Learning fuels progress'),
                        TyperAnimatedText('Let\'s Start...'),
                      ],
                      totalRepeatCount: 1,
                      onFinished: () {
                        Navigator.pushNamed(context, RoutesName.login);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
