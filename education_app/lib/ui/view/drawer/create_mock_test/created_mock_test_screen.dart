import 'package:education_app/resources/exports.dart';

class CreatedMockTestScreen extends StatefulWidget {
  final bool testMode;
  final String questionMode;
  final String subjectMode;
  final double numberOfQuestions;

  const CreatedMockTestScreen({
    super.key,
    required this.numberOfQuestions,
    required this.questionMode,
    required this.subjectMode,
    required this.testMode,
  });

  @override
  _CreatedMockTestScreenState createState() => _CreatedMockTestScreenState();
}

class _CreatedMockTestScreenState extends State<CreatedMockTestScreen> {
  late MockTestProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (kDebugMode){
      //   print("widget.numberOfQuestions = ${widget.numberOfQuestions}");
      // }
      final provider = Provider.of<MockTestProvider>(context, listen: false);
      provider.setSelectedSubject(widget.subjectMode);
      provider.setNumberOfQuestion(widget.numberOfQuestions);

    });
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
        // actions: [
        //   PopupMenuButton<String>(
        //     icon: Icon(
        //       Icons.more_vert,
        //     ),
        //     onSelected: (value) {
        //       if (value == 'Feedback') {
        //         print('Option 1 selected');
        //       }
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return [
        //         PopupMenuItem(
        //           value: 'Feedback',
        //           child: Text('Feedback'),
        //         ),
        //       ];
        //     },
        //   ),
        //   SizedBox(
        //     width: 5,
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<MockTestProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                const SizedBox(height: 10),
                if (!provider.isTestStarted) _buildStartTestSection(provider),
                if (provider.isTestStarted) _buildTestControls(provider),
                const SizedBox(height: 10),
                _buildQuestionCard(provider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStartTestSection(MockTestProvider provider) {
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

  Widget _buildTestControls(MockTestProvider provider) {
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

  Widget _buildQuestionCard(MockTestProvider provider) {
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
                "${provider.currentIndex + 1}) ${provider.selectSubject[provider.currentIndex].question}",
                style: AppTextStyle.questionText,
              ),
              const SizedBox(height: 10),
              ...List.generate(
                provider.selectSubject[provider.currentIndex].options.length,
                (optionIndex) => ListTile(
                  title: Text(
                    provider.selectSubject[provider.currentIndex]
                        .options[optionIndex],
                    style: AppTextStyle.answerText,
                  ),
                  leading: Radio<int>(
                    value: optionIndex,
                    groupValue: provider.selectedOptions[provider.currentIndex],
                    onChanged: provider.isSubmitted[provider.currentIndex]
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

  Widget _buildNavigationButtons(MockTestProvider provider) {
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

  Widget _buildExplanation(MockTestProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => showFeedbackDialog(
              context, (provider.currentIndex + 1), provider.selectedSubject!),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: 90,
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
            provider.selectSubject[provider.currentIndex].detail,
            style: AppTextStyle.answerText,
          ),
      ],
    );
  }
  void showFeedbackDialog(BuildContext context, int questionNum, String selectSubject ) {
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
