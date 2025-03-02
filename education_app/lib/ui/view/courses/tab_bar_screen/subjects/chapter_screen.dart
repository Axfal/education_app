// ignore_for_file: prefer_const_constructors

import 'package:education_app/resources/exports.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final chapterProvider =
          Provider.of<ChapterProvider>(context, listen: false);
      final subjectProvider =
          Provider.of<SubjectProvider>(context, listen: false);

      while (
          subjectProvider.subject == null || subjectProvider.subject!.isEmpty) {
        await Future.delayed(Duration(milliseconds: 100));
      }

      chapterProvider.setData(
        subjectProvider.testId,
        subjectProvider.selectedSubjectId,
        subjectProvider.subject!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChapterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chapters', style: AppTextStyle.appBarText),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            provider.reset();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: provider.chapterName.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: provider.chapterName.length,
                itemBuilder: (context, index) {
                  int questionNumber =
                      int.tryParse(provider.chapterNo[index]) ?? (index + 1);

                  return InkWell(
                    onTap: () => _onChapterTap(context, provider, index),
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Center(
                            child: Text(
                              '${questionNumber + 1}',
                              style: AppTextStyle.appBarText,
                            ),
                          ),
                        ),
                        title: Text(provider.chapterName[index],
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _onChapterTap(
      BuildContext context, ChapterProvider provider, int index) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    provider.openChapter(index);

    if (authProvider.userSession?.userType == "premium") {
      Navigator.pushNamed(context, RoutesName.questionScreen, arguments: {
        "subjectId": provider.subjectId,
        "chapterId": provider.chapterId
      });
    } else {
      _showPremiumAccessDialog(context);
    }
  }

  void _showPremiumAccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Premium Access Required"),
        content: Text(
          "This feature is available only for premium users. Upgrade now to unlock exclusive content and enhance your learning experience!",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, RoutesName.subscriptionScreen);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text('Get Subscription',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
