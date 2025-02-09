import 'package:education_app/resources/exports.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final List<bool> _showExplanation = List.generate(10, (index) => false);
  final List<bool> _isCheckedList = List.generate(10, (index) => false);
  final Map<int, String> _selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedAnswers.clear();
                _showExplanation.fillRange(0, _showExplanation.length, false);
                _isCheckedList.fillRange(0, _isCheckedList.length, false);
              });
            },
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Text(
                      '${index + 1}.',
                      style: TextStyle(fontSize: 18),
                    ),
                    title: Text(
                      'Which of the following is a characteristic of Simple Harmonic Motion (SHM)?',
                      style: AppTextStyle.questionText,
                    ),
                    trailing: Checkbox(
                      value: _isCheckedList[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _isCheckedList[index] = value ?? false;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  for (var option in ['A', 'B', 'C', 'D'])
                    ListTile(
                      title: Text(
                        option == 'A'
                            ? 'Non-periodic motion'
                            : option == 'B'
                                ? 'Motion with constant velocity'
                                : option == 'C'
                                    ? 'Motion with acceleration proportional to displacement'
                                    : 'Uniform circular motion',
                        style: AppTextStyle.answerText,
                      ),
                      leading: Radio<String>(
                        value: option,
                        groupValue: _selectedAnswers[index],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedAnswers[index] = value!;
                          });
                        },
                      ),
                    ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Show Explanation',
                        style: AppTextStyle.questionText,
                      ),
                      Switch(
                        value: _showExplanation[index],
                        onChanged: (value) {
                          setState(() {
                            if (_selectedAnswers[index] != null) {
                              _showExplanation[index] = value;
                            } else {
                              null;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  if (_showExplanation[index] &&
                      _selectedAnswers[index] != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16),
                      child: Text(
                        'Simple Harmonic Motion (SHM) is characterized by acceleration '
                        'that is directly proportional to displacement and acts in the '
                        'direction opposite to that of displacement.',
                        style: AppTextStyle.answerText,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
