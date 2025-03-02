// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:education_app/resources/exports.dart';

class QuestionScreen extends StatefulWidget {
  final int subjectId;
  final int chapterId;
  const QuestionScreen(
      {super.key, required this.subjectId, required this.chapterId});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void getData() async {
    try {
      final provider = Provider.of<QuestionsProvider>(context, listen: false);
      await provider.fetchQuestions(
          context, widget.subjectId, widget.chapterId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching questions: $e")),
        );
      }
    }
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final subjectProvider = Provider.of<SubjectProvider>(context);
    final chapterProvider = Provider.of<ChapterProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                provider.goBack();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: AppColors.primaryColor,
          actions: [
            TextButton(
                onPressed: () {
                  if (count < 2) {
                    provider.restartTest();
                    count += 1;
                  }
                },
                child: Text(
                  'Reset',
                  style: AppTextStyle.subscriptionDetailText,
                )),
            SizedBox(
              width: 5,
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return {'All', 'Unused', 'Incorrect', 'Marked'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: provider.loading
            ? Center(child: CircularProgressIndicator())
            : provider.questions == null ||
                    provider.questions!.questions.isEmpty
                ? Center(
                    child: Text(
                      'No questions available.',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.numberOfQuestions,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Text('${index + 1}',
                                    style: AppTextStyle.questionText),
                                title: Text(
                                    provider.questionList[index].question,
                                    style: AppTextStyle.questionText),
                                trailing: Checkbox(
                                  value: provider.isChecked[index],
                                  onChanged: (bool? value) {
                                    provider.checkBox(index, value ?? false);
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                title: Text(
                                    provider.questions!.questions[index].option1
                                        .replaceAll(RegExp(r'[a-d]\)'), '')
                                        .trim(),
                                    style: AppTextStyle.answerText),
                                leading: Radio<int>(
                                  value: 0,
                                  groupValue: provider.selectedOptions[index],
                                  onChanged: !provider.isSubmitted[index]
                                      ? (value) {
                                          if (value != null) {
                                            provider.onChangeRadio(
                                                index, value);
                                          }
                                        }
                                      : null,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                    provider.questions!.questions[index].option2
                                        .replaceAll(RegExp(r'[a-d]\)'), '')
                                        .trim(),
                                    style: AppTextStyle.answerText),
                                leading: Radio<int>(
                                  value: 1,
                                  groupValue: provider.selectedOptions[index],
                                  onChanged: !provider.isSubmitted[index]
                                      ? (value) {
                                          if (value != null) {
                                            provider.onChangeRadio(
                                                index, value);
                                          }
                                        }
                                      : null,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                    provider.questions!.questions[index].option3
                                        .replaceAll(RegExp(r'[a-d]\)'), '')
                                        .trim(),
                                    style: AppTextStyle.answerText),
                                leading: Radio<int>(
                                  value: 2,
                                  groupValue: provider.selectedOptions[index],
                                  onChanged: !provider.isSubmitted[index]
                                      ? (value) {
                                          if (value != null) {
                                            provider.onChangeRadio(
                                                index, value);
                                          }
                                        }
                                      : null,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                    provider.questions!.questions[index].option4
                                        .replaceAll(RegExp(r'[a-d]\)'), '')
                                        .trim(),
                                    style: AppTextStyle.answerText),
                                leading: Radio<int>(
                                  value: 3,
                                  groupValue: provider.selectedOptions[index],
                                  onChanged: !provider.isSubmitted[index]
                                      ? (value) {
                                          if (value != null) {
                                            provider.onChangeRadio(
                                                index, value);
                                          }
                                        }
                                      : null,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => showFeedbackDialog(
                                    context,
                                    authProvider.userSession!.userId,
                                    authProvider.userSession!.testId,
                                    subjectProvider.selectedSubjectId,
                                    chapterProvider.chapterId,
                                    provider.questions!.questions[index].id),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: AppColors.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 15),
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                                child: Text('Feedback'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Show Explanation',
                                      style: AppTextStyle.questionText),
                                  Switch(
                                    value: (index <
                                                provider
                                                    .showExplanation.length &&
                                            provider.selectedOptions[index] !=
                                                null)
                                        ? provider.showExplanation[index]
                                        : false,
                                    onChanged: (value) {
                                      if (index <
                                              provider.showExplanation.length &&
                                          provider.selectedOptions[index] !=
                                              null) {
                                        provider.toggleExplanationSwitch(
                                            index, value);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              if (provider.showExplanation[index])
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15),
                                  child: Text(
                                    provider.questions!.questions[index].detail,
                                    style: AppTextStyle.answerText,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }));
  }

  void showFeedbackDialog(BuildContext context, int userId, int testId,
      int subjectId, int chapterId, int questionId) {
    final formKey = GlobalKey<FormState>();
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Share Feedback',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: feedbackController,
                  decoration: InputDecoration(
                    labelText: 'Your Feedback',
                    hintText: 'Enter any issues or suggestions',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final feedbackProvider =
                          Provider.of<FeedbackProvider>(context, listen: false);
                      Map<String, dynamic> data = {
                        "user_id": userId,
                        "test_id": testId,
                        "subject_id": subjectId,
                        "chapter_id": chapterId,
                        "question_id": questionId,
                        "detail": feedbackController.text
                      };
                      if (kDebugMode) {
                        print(data);
                      }
                      feedbackProvider.giveFeedback(context, data);
                      // if(feedbackProvider.feedback!.success == true) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //         content: Text('Feedback Submitted Successfully!'),
                      //         backgroundColor: Colors.green),
                      //     snackBarAnimationStyle:
                      //         AnimationStyle(duration: Duration(seconds: 2)));
                      // }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child:
                      Text('Submit', style: AppTextStyle.subscriptionTitleText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
