import 'package:education_app/resources/exports.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final List<String> _subjects = <String>[
    'Physics',
    'Chemistry',
    'English',
    'Biology',
    'Analytical Reasoning'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return SubjectTitleScreen(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.chapterScreen);
            },
            title: _subjects[index],
            image: 'assets/images/mdcat.png',
          );
        },
      ),
    );
  }
}
