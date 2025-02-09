import 'package:education_app/resources/exports.dart';

class MockTestScreen extends StatefulWidget {
  const MockTestScreen({super.key});

  @override
  _MockTestScreenState createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen> {
  @override
  Widget build(BuildContext context) {
    final mockTestModel = mockTextPhysicsQuestions;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<MockTestProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!provider.isTestStarted)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  ],
                ),
                if (provider.isTestStarted)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () => provider.navigate(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                            "${provider.currentIndex + 1}) ${mockTestModel[provider.currentIndex].question}",
                            style: AppTextStyle.questionText,
                          ),
                          SizedBox(height: 10),
                          ...List.generate(
                            mockTestModel[provider.currentIndex].options.length,
                            (optionIndex) => ListTile(
                              title: Text(
                                  mockTestModel[provider.currentIndex]
                                      .options[optionIndex],
                                  style: AppTextStyle.answerText),
                              leading: Radio<int>(
                                value: optionIndex,
                                groupValue: provider
                                    .selectedOptions[provider.currentIndex],
                                onChanged:
                                    provider.isSubmitted[provider.currentIndex]
                                        ? null
                                        : (value) {
                                            if (value != null) {
                                              provider.onChangeRadio(
                                                  provider.currentIndex, value);
                                            }
                                          },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: provider.isPrevEnabled
                                    ? provider.goToPrevious
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: provider.isPrevEnabled
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                                child: Icon(Icons.arrow_back_ios,
                                    color: provider.isPrevEnabled
                                        ? Colors.white
                                        : Colors.black38),
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
                                onPressed: provider.isNxtEnabled
                                    ? provider.goToNext
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: provider.isNxtEnabled
                                      ? AppColors.primaryColor
                                      : Colors.grey,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  textStyle: TextStyle(fontSize: 18),
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
                                context, (provider.currentIndex + 1)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Show Explanation',
                                  style: AppTextStyle.questionText),
                              Switch(
                                  value: provider
                                      .showExplanation[provider.currentIndex],
                                  onChanged: (value) =>
                                      provider.toggleExplanationSwitch(value)),
                            ],
                          ),
                          if (provider.showExplanation[provider.currentIndex] &&
                              provider.isSubmitted[provider.currentIndex])
                            Text(
                              mockTestModel[provider.currentIndex].detail,
                              style: AppTextStyle.answerText,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
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
