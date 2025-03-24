// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:education_app/resources/exports.dart';

class CreateMockTest extends StatefulWidget {
  const CreateMockTest({super.key});

  @override
  State<CreateMockTest> createState() => _CreateMockTestState();
}

class _CreateMockTestState extends State<CreateMockTest> {
  bool enableTimer = false;
  String? selectedQuestion;
  Set<String> selectedSubjectIds = {};
  Map<String, String> subjects = {};

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  void fetchSubjects() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final int testId = authProvider.userSession!.testId;

      final subjectProvider =
          Provider.of<SubjectProvider>(context, listen: false);
      await subjectProvider.setSubjects(testId);

      setState(() {
        subjects = Map.fromIterables(
            subjectProvider.subjectId.map((id) => id.toString()),
            subjectProvider.subjects);
      });

      if (kDebugMode) {
        print("subjects are ==> $subjects");
      }
    } catch (e) {
      rethrow;
    }
  }

  final List<String> _questions = [
    'unused',
    'incorrect',
    'marked',
    'all',
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
      body: subjects.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
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
                Consumer<CreateMockTestProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        child: ExpansionTile(
                          title: Text('Subjects Mode'),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: subjects.entries.map((entry) {
                                String subjectId = entry.key;
                                String subjectName = entry.value;
                                return ListTile(
                                  leading: Checkbox(
                                    activeColor: AppColors.primaryColor,
                                    value:
                                        selectedSubjectIds.contains(subjectId),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedSubjectIds.add(subjectId);
                                        } else {
                                          selectedSubjectIds.remove(subjectId);
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(subjectName),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                                    activeColor: AppColors.primaryColor,
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
                                      // numIcon('445')
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<CreateMockTestProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        child: ExpansionTile(
                          title: Text('Number of Questions'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Slider(
                                    activeColor: AppColors.primaryColor,
                                    value: provider.numberOfQuestions
                                        .toDouble()
                                        .clamp(10.0, 100.0),
                                    min: 10,
                                    max: 100,
                                    divisions: 99,
                                    label: provider.numberOfQuestions
                                        .round()
                                        .toString(),
                                    onChanged: (value) {
                                      provider.setNumberOfQuestion(value);
                                    },
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Selected: ${provider.numberOfQuestions.round()} questions',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Consumer<CreateMockTestProvider>(
                    builder: (context, provider, child) {
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedSubjectIds.isNotEmpty &&
                              selectedQuestion != null) {
                            try {
                              List<int> subjectIds = selectedSubjectIds
                                  .map((id) => int.tryParse(id) ?? -1)
                                  .where((id) => id != -1)
                                  .toList();
                              print(
                                  "Subjects IDs are these ======> $subjectIds");
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesName.createdMockTestScreen,
                                arguments: {
                                  'test_mode': enableTimer,
                                  'question_mode': selectedQuestion,
                                  'subject_mode': subjectIds,
                                  'number_of_questions':
                                      provider.numberOfQuestions.toDouble()
                                },
                              );
                            } catch (e) {
                              print("Error converting subject IDs: $e");
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Please select all options before submitting!")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.textColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
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
