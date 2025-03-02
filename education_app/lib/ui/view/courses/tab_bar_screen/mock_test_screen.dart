// ignore_for_file: prefer_const_constructors

import 'package:education_app/resources/exports.dart';

class MockTestScreen extends StatefulWidget {
  final int subjectId;
  final int chapterId;
  const MockTestScreen({super.key, this.subjectId = 0, this.chapterId = 0});

  @override
  MockTestScreenState createState() => MockTestScreenState();
}

class MockTestScreenState extends State<MockTestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() async {
    try {
      await Provider.of<MockTestProvider>(context, listen: false)
          .fetchQuestions(context);
    } catch (e) {
      debugPrint("Failed to fetch questions: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load questions.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MockTestProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
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
                : provider.currentIndex >= provider.questions!.questions.length
                    ? Center(
                        child: Text('No questions available.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            if (!provider.isTestStarted)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  onPressed: provider.startTest,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.primaryColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 15),
                                    textStyle: TextStyle(fontSize: 18),
                                  ),
                                  child: Text('Start Test'),
                                ),
                              ),
                            if (provider.isTestStarted)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  onPressed: () => provider.navigate(context),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.primaryColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    textStyle: TextStyle(fontSize: 18),
                                  ),
                                  child: Text('End Test'),
                                ),
                              ),
                            SizedBox(height: 20),
                            Expanded(
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
                                        "${provider.currentIndex + 1}) ${provider.questions!.questions[provider.currentIndex].question}",
                                        style: AppTextStyle.questionText,
                                      ),
                                      SizedBox(height: 10),
                                      ListTile(
                                        title: Text(
                                            provider
                                                .questions!
                                                .questions[
                                                    provider.currentIndex]
                                                .option1
                                                .replaceAll(
                                                    RegExp(r'[a-d]\)'), '')
                                                .trim(),
                                            style: AppTextStyle.answerText),
                                        leading: Radio<int>(
                                          value: 0,
                                          groupValue: provider.selectedOptions[
                                              provider.currentIndex],
                                          onChanged: provider.isTestStarted &&
                                                  !provider.isSubmitted[
                                                      provider.currentIndex]
                                              ? (value) {
                                                  if (value != null) {
                                                    provider.onChangeRadio(
                                                        provider.currentIndex,
                                                        value);
                                                  }
                                                }
                                              : null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                            provider
                                                .questions!
                                                .questions[
                                                    provider.currentIndex]
                                                .option2
                                                .replaceAll(
                                                    RegExp(r'[a-d]\)'), '')
                                                .trim(),
                                            style: AppTextStyle.answerText),
                                        leading: Radio<int>(
                                          value: 1,
                                          groupValue: provider.selectedOptions[
                                              provider.currentIndex],
                                          onChanged: provider.isTestStarted &&
                                                  !provider.isSubmitted[
                                                      provider.currentIndex]
                                              ? (value) {
                                                  if (value != null) {
                                                    provider.onChangeRadio(
                                                        provider.currentIndex,
                                                        value);
                                                  }
                                                }
                                              : null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                            provider
                                                .questions!
                                                .questions[
                                                    provider.currentIndex]
                                                .option3
                                                .replaceAll(
                                                    RegExp(r'[a-d]\)'), '')
                                                .trim(),
                                            style: AppTextStyle.answerText),
                                        leading: Radio<int>(
                                          value: 2,
                                          groupValue: provider.selectedOptions[
                                              provider.currentIndex],
                                          onChanged: provider.isTestStarted &&
                                                  !provider.isSubmitted[
                                                      provider.currentIndex]
                                              ? (value) {
                                                  if (value != null) {
                                                    provider.onChangeRadio(
                                                        provider.currentIndex,
                                                        value);
                                                  }
                                                }
                                              : null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                            provider
                                                .questions!
                                                .questions[
                                                    provider.currentIndex]
                                                .option4
                                                .replaceAll(
                                                    RegExp(r'[a-d]\)'), '')
                                                .trim(),
                                            style: AppTextStyle.answerText),
                                        leading: Radio<int>(
                                          value: 3,
                                          groupValue: provider.selectedOptions[
                                              provider.currentIndex],
                                          onChanged: provider.isTestStarted &&
                                                  !provider.isSubmitted[
                                                      provider.currentIndex]
                                              ? (value) {
                                                  if (value != null) {
                                                    provider.onChangeRadio(
                                                        provider.currentIndex,
                                                        value);
                                                  }
                                                }
                                              : null,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: provider.isPrevEnabled
                                                ? provider.goToPrevious
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  provider.isPrevEnabled
                                                      ? AppColors.primaryColor
                                                      : Colors.grey,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15),
                                              textStyle:
                                                  TextStyle(fontSize: 18),
                                            ),
                                            child: Icon(Icons.arrow_back_ios,
                                                color: provider.isPrevEnabled
                                                    ? Colors.white
                                                    : Colors.black38),
                                          ),
                                          ElevatedButton(
                                            onPressed: provider.isTestStarted ==
                                                        false ||
                                                    provider.isSubmitted[
                                                        provider.currentIndex]
                                                ? null
                                                : () => provider.submitAnswer(
                                                    context,
                                                    provider.currentIndex),
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              textStyle:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: provider.isNxtEnabled
                                                ? provider.goToNext
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  provider.isNxtEnabled
                                                      ? AppColors.primaryColor
                                                      : Colors.grey,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              textStyle:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            child: Icon(Icons.arrow_forward_ios,
                                                color: provider.isNxtEnabled
                                                    ? Colors.white
                                                    : Colors.black38),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () => showFeedbackDialog(
                                            context,
                                            (provider.currentIndex + 1)),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          padding: EdgeInsets.symmetric(
                                              // horizontal: 50,
                                              vertical: 15),
                                          textStyle: TextStyle(fontSize: 18),
                                        ),
                                        child: Text('Feedback'),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Show Explanation',
                                              style: AppTextStyle.questionText),
                                          Switch(
                                              value: provider.showExplanation[
                                                  provider.currentIndex],
                                              onChanged: (value) => provider
                                                  .toggleExplanationSwitch(
                                                      value)),
                                        ],
                                      ),
                                      if (provider.showExplanation[
                                              provider.currentIndex] &&
                                          provider.isSubmitted[
                                              provider.currentIndex])
                                        Text(
                                          provider
                                              .questions!
                                              .questions[provider.currentIndex]
                                              .detail,
                                          style: AppTextStyle.answerText,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )));
  }

  void showFeedbackDialog(BuildContext context, int questionNum) {
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
                                'Feedback Submitted Successfully! quetion number is $questionNum')),
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
