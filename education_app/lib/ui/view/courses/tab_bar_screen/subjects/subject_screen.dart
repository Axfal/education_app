// ignore_for_file: prefer_const_constructors

import 'package:education_app/resources/exports.dart';

class SubjectScreen extends StatefulWidget {
  final courseId;
  const SubjectScreen({super.key, required this.courseId});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print(widget.courseId);
    }
    getSubjects();
  }

  void getSubjects() async {
    try{
      final subjectProvider =
      Provider.of<SubjectProvider>(context, listen: false);
      await subjectProvider.setSubjects(widget.courseId);
      subjectProvider.setTestId(widget.courseId);
    }catch(e){
      rethrow;
    }

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubjectProvider>(context);
    // final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      // appBar: authProvider.userSession?.userType == 'free'
      //     ? null
      //     : AppBar(
      //         backgroundColor: AppColors.primaryColor,
      //         centerTitle: true,
      //         title: Text(
      //           'Subject',
      //           style: AppTextStyle.appBarText,
      //         )),
      body: provider.subjectId.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: provider.subjects.length,
                itemBuilder: (context, index) {
                  return SubjectTitleScreen(
                    onTap: () async {
                      try {
                        final subjectProvider = Provider.of<SubjectProvider>(
                            context,
                            listen: false);
                        final chapterProvider = Provider.of<ChapterProvider>(
                            context,
                            listen: false);


                        int subjectId = subjectProvider.subjectId[index];
                        subjectProvider.setSelectedSubjectId(subjectId);
                        int testId = subjectProvider.testId;
                        String subjectName = subjectProvider.subjects[index];
                        subjectProvider.setSelectedSubjectId(subjectId);
                        Navigator.pushNamed(context, RoutesName.chapterScreen);
                        await chapterProvider.setData(testId, subjectId, subjectName);
                      } catch (e) {
                        if (kDebugMode) {
                          print("Navigation error: $e");
                        }
                        rethrow;
                      }
                    },
                    title: provider.subjects[index],
                    image: 'assets/images/mdcat.png',
                  );
                },
              ),
            ),
    );
  }
}
