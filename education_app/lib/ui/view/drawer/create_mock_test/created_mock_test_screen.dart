// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:education_app/resources/exports.dart';

class CreatedMockTestScreen extends StatefulWidget {
  final bool testMode;
  final String questionMode;
  final List<int> subjectMode;
  final double numberOfQuestions;

  const CreatedMockTestScreen({
    super.key,
    required this.numberOfQuestions,
    required this.questionMode,
    required this.subjectMode,
    required this.testMode,
  });

  @override
  CreatedMockTestScreenState createState() => CreatedMockTestScreenState();
}

class CreatedMockTestScreenState extends State<CreatedMockTestScreen> {
  // late MockTestsProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getQuestions();
    });
  }

  void getQuestions() async {
    final provider =
        Provider.of<CreateMockTestProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final subjectProvider =
        Provider.of<SubjectProvider>(context, listen: false);

    if (!mounted) return;

    final userId = authProvider.userSession?.userId;
    final testId = subjectProvider.testId;

    if (userId == null) {
      print("❌ ERROR: User ID is null! Cannot fetch questions.");
      return;
    }

    print("🔍 Fetching Questions for:");
    print("👤 User ID: $userId");
    print("📝 Test ID: $testId");
    print("📚 Subject Mode: ${widget.subjectMode}");
    print("🔢 Number of Questions: ${widget.numberOfQuestions}");

    Map<String, dynamic> data = {
      "user_id": userId,
      "test_id": testId,
      "subject_id": widget.subjectMode,
      "no_of_question": widget.numberOfQuestions.toInt()
    };

    await provider.getQuestions(context, data);
  }

  // Add this helper method to remove HTML tags
  String removeHtmlTags(String? htmlText) {
    if (htmlText == null) return '';

    // First, decode HTML entities
    var text = htmlText
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');

    // Then remove HTML tags
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Mock Test',
          style: AppTextStyle.appBarText,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<CreateMockTestProvider>(
          builder: (context, provider, child) {
            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.questionList.isEmpty) {
              return const Center(
                  child: Text("No questions available. Please try again."));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  if (!provider.isTestStarted) _buildStartTestSection(provider),
                  if (provider.isTestStarted) _buildTestControls(provider),
                  const SizedBox(height: 10),
                  _buildQuestionCard(provider),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildStartTestSection(CreateMockTestProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: provider.startTest,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text('Start Test'),
        ),
        const SizedBox(height: 20),
        if (widget.testMode)
          Text(
            'Total Time: ${provider.timeInSeconds} sec',
            style: AppTextStyle.profileTitleText,
          ),
      ],
    );
  }

  Widget _buildTestControls(CreateMockTestProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.testMode)
          CountdownTimer(
            endTime: provider.endTime,
            onEnd: () => provider.navigate(context),
            widgetBuilder: (_, time) {
              if (time == null) {
                return Text('Time\'s up!',
                    style: AppTextStyle.profileTitleText);
              }
              return Text(
                'Time Left: ${time.sec} sec',
                style: AppTextStyle.profileTitleText,
              );
            },
          ),
      ],
    );
  }

  Widget _buildQuestionCard(CreateMockTestProvider provider) {
    if (provider.questionList.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No questions available'),
        ),
      );
    }

    if (provider.currentIndex >= provider.questionList.length) {
      return const Expanded(
        child: Center(
          child: Text('Invalid question index'),
        ),
      );
    }

    final currentQuestion = provider.questionList[provider.currentIndex];

    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "${provider.currentIndex + 1}) ${removeHtmlTags(currentQuestion.question)}",
                style: AppTextStyle.questionText,
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                    removeHtmlTags(currentQuestion.option1)
                        .replaceAll(RegExp(r'[a-d]\)'), '')
                        .trim(),
                    style: AppTextStyle.answerText),
                leading: Radio<int>(
                  value: 0,
                  groupValue: provider.selectedOptions[provider.currentIndex],
                  onChanged: provider.isTestStarted &&
                          !provider.isSubmitted[provider.currentIndex]
                      ? (value) {
                          if (value != null) {
                            provider.onChangeRadio(
                                provider.currentIndex, value);
                          }
                        }
                      : null,
                ),
              ),
              ListTile(
                title: Text(
                    removeHtmlTags(currentQuestion.option2)
                        .replaceAll(RegExp(r'[a-d]\)'), '')
                        .trim(),
                    style: AppTextStyle.answerText),
                leading: Radio<int>(
                  value: 1,
                  groupValue: provider.selectedOptions[provider.currentIndex],
                  onChanged: provider.isTestStarted &&
                          !provider.isSubmitted[provider.currentIndex]
                      ? (value) {
                          if (value != null) {
                            provider.onChangeRadio(
                                provider.currentIndex, value);
                          }
                        }
                      : null,
                ),
              ),
              ListTile(
                title: Text(
                    removeHtmlTags(currentQuestion.option3)
                        .replaceAll(RegExp(r'[a-d]\)'), '')
                        .trim(),
                    style: AppTextStyle.answerText),
                leading: Radio<int>(
                  value: 2,
                  groupValue: provider.selectedOptions[provider.currentIndex],
                  onChanged: provider.isTestStarted &&
                          !provider.isSubmitted[provider.currentIndex]
                      ? (value) {
                          if (value != null) {
                            provider.onChangeRadio(
                                provider.currentIndex, value);
                          }
                        }
                      : null,
                ),
              ),
              ListTile(
                title: Text(
                    removeHtmlTags(currentQuestion.option4)
                        .replaceAll(RegExp(r'[a-d]\)'), '')
                        .trim(),
                    style: AppTextStyle.answerText),
                leading: Radio<int>(
                  value: 3,
                  groupValue: provider.selectedOptions[provider.currentIndex],
                  onChanged: provider.isTestStarted &&
                          !provider.isSubmitted[provider.currentIndex]
                      ? (value) {
                          if (value != null) {
                            provider.onChangeRadio(
                                provider.currentIndex, value);
                          }
                        }
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              _buildNavigationButtons(provider),
              const SizedBox(height: 10),
              _buildExplanation(provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(CreateMockTestProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: provider.isPrevEnabled ? provider.goToPrevious : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor:
                provider.isPrevEnabled ? AppColors.primaryColor : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        ElevatedButton(
          onPressed: provider.isSubmitted[provider.currentIndex]
              ? null
              : () => provider.submitAnswer(context, provider.currentIndex),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: provider.isNxtEnabled ? provider.goToNext : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor:
                provider.isNxtEnabled ? AppColors.primaryColor : Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildExplanation(CreateMockTestProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => showFeedbackDialog(
              context, (provider.currentIndex + 1), 'Created Mock Test'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text('Feedback'),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Show Explanation', style: AppTextStyle.questionText),
            Switch(
              value: provider.showExplanation[provider.currentIndex],
              onChanged: (value) => provider.toggleExplanationSwitch(value),
            ),
          ],
        ),
        if (provider.showExplanation[provider.currentIndex] &&
            provider.isSubmitted[provider.currentIndex])
          Text(
            removeHtmlTags(
                    provider.questionList[provider.currentIndex].detail) ??
                "No explanation available.",
            style: AppTextStyle.answerText,
          ),
      ],
    );
  }

  void showFeedbackDialog(
      BuildContext context, int questionNum, String selectSubject) {
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Feedback Submitted Successfully! subject is $selectSubject quetion number is $questionNum')),
                      );
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
