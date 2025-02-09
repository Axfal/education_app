import 'package:education_app/resources/exports.dart';

class ResultScreen extends StatefulWidget {
  final int correctAns;
  final int incorrectAns;
  final int totalQues;

  const ResultScreen({
    super.key,
    required this.correctAns,
    required this.incorrectAns,
    required this.totalQues,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isPass = false;
  late Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
    setMapData();
    isPassed();

  }

  // void setPreviousTestData(){
  //   final _provider = Provider.of<PreviousTestProvider>(context);
  //   _provider.setTestData(isPassed.percentage, subject, isPass)
  // }
  void setMapData() {
    dataMap = {
      'Correct': widget.correctAns.toDouble(),
      'Incorrect': widget.incorrectAns.toDouble(),
      'Unattempted': max(
        0,
        widget.totalQues.toDouble() - (widget.correctAns + widget.incorrectAns),
      ),
    };
  }

  void isPassed() {
    final percentage = (widget.correctAns / widget.totalQues) * 100;
    isPass = percentage > 50;
  }

  void _showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            message,
            style: AppTextStyle.profileTitleText,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: AppTextStyle.appBarText,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            PieChart(
              dataMap: dataMap,
              colorList: [
                Colors.green.shade600,
                Colors.red.shade600,
                Colors.yellow.shade600,
              ],
              ringStrokeWidth: 30,
              chartType: ChartType.disc,
              animationDuration: const Duration(seconds: 2),
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Correct Answers: ${dataMap['Correct']?.toInt()}',
                  style: AppTextStyle.profileTitleText,
                ),
                Text(
                  'Incorrect Answers: ${dataMap['Incorrect']?.toInt()}',
                  style: AppTextStyle.profileTitleText,
                ),
                Text(
                  'Unattempted: ${dataMap['Unattempted']?.toInt()}',
                  style: AppTextStyle.profileTitleText,
                ),
              ],
            ),
            const SizedBox(height: 40),
            reusableButton(
              isPass ? 'Congratulate Me!' : 'Better Luck Next Time!',
                  () => _showMessage(
                isPass ? 'Congratulations!' : 'Try Again!',
                isPass
                    ? 'You did a great job! Keep up the good work.'
                    : 'Keep practicing and you’ll improve!',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MockTestProvider>(context, listen: false).resetProvider();
          Navigator.pop(context);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.restart_alt, color: Colors.white),
      ),
    );
  }
}
