import 'package:education_app/resources/exports.dart';

class CourseScreen extends StatefulWidget {
  final courseId;
  const CourseScreen({super.key,required this.courseId});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    MockTestProvider provider = Provider.of<MockTestProvider>(context);
    // final courseProvider = Provider.of<AuthProvider>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              provider.restartTest();
              Navigator.pushNamed(context, RoutesName.home);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.school), text: 'Subjects'),
              Tab(icon: Icon(Icons.quiz), text: 'Mock Test'),
            ],
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
          ),
        ),
        body: TabBarView(
          children: [
            SubjectScreen(courseId: widget.courseId,),
            const MockTestScreen(),
          ],
        ),
      ),
    );
  }
}
