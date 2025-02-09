import 'package:education_app/resources/exports.dart';

class CreateMockTest extends StatefulWidget {
  const CreateMockTest({super.key});

  @override
  State<CreateMockTest> createState() => _CreateMockTestState();
}

class _CreateMockTestState extends State<CreateMockTest> {
  bool enableTimer = false;
  String? selectedQuestion;
  // static double? currentValue;

  final List<String> _subjects = [
    'English',
    'Physics',
    'Chemistry',
    'Biology',
    'Analytical Reasoning'
  ];
  final List<String> _questions = [
    'Unused',
    'Incorrect',
    'Marked',
    'All',
    'Custom',
    'Standard'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Mock Test',
          style: AppTextStyle.appBarText,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.textColor)),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text('Please select options to generate mock test.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              child: ExpansionTile(
                title: Text('Test Mode'),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Tutor',
                            style: AppTextStyle.profileTitleText,
                          ),
                          trailing: Switch(
                            activeColor: AppColors.primaryColor,
                            value: !enableTimer,
                            onChanged: (value) {
                              setState(() {
                                enableTimer = !value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Timed',
                            style: AppTextStyle.profileTitleText,
                          ),
                          trailing: Switch(
                            activeColor: AppColors.primaryColor,
                            value: enableTimer,
                            onChanged: (value) {
                              setState(() {
                                enableTimer = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              child: ExpansionTile(
                title: Text('Question Mode'),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._questions.map((question) => ListTile(
                            leading: Radio<String>(
                              value: question,
                              groupValue: selectedQuestion,
                              onChanged: (value) {
                                setState(() {
                                  selectedQuestion = value;
                                });
                              },
                            ),
                            title: Row(
                              children: [
                                Text(
                                  question,
                                  // style: AppTextStyle.profileSubTitleText,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                numIcon('445')
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Consumer<MockTestProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  child: ExpansionTile(
                    title: Text('Subjects Mode'),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._subjects.map((subject) {
                            return ListTile(
                              leading: Radio<String>(
                                value: subject,
                                groupValue: provider.selectedSubject,
                                onChanged: (value) {
                                  provider.setSelectedSubject(value!);
                                },
                              ),
                              title: Text(subject),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )

          //number of questions
          ,
          Consumer<MockTestProvider>(builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: ExpansionTile(
                  title: Text('Number of Questions'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 2),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Slider(
                              value: provider.numberOfQuestions.toDouble(),
                              min: 1,
                              max: 10,
                              divisions: 9,
                              label:
                                  provider.numberOfQuestions.round().toString(),
                              onChanged: (value) {
                                provider.setNumberOfQuestion(value);
                              },
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Selected: ${provider.numberOfQuestions.round()} questions',
                              // style: AppTextStyle.profileSubTitleText
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          Consumer<MockTestProvider>(builder: (context, provider, child) {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (provider.selectedSubject != null &&
                        selectedQuestion != null) {
                      Navigator.pushReplacementNamed(
                          context, RoutesName.createdMockTestScreen,
                          arguments: {
                            'test_mode': enableTimer,
                            'question_mode': selectedQuestion,
                            'subject_mode': provider.selectedSubject,
                            'number_of_questions':
                                provider.numberOfQuestions.toDouble()
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Please select all option before submitting!")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.textColor,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text('Generate'),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget numIcon(String title) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(title, style: AppTextStyle.subscriptionDetailText),
      );
}
