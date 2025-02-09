import 'package:education_app/resources/exports.dart';
import 'package:intl/intl.dart';

class PreviousTestProvider with ChangeNotifier {
  late String _testDate;
  String get testDate => _testDate;

  late int _percentage;
  int get percentage => _percentage;

  late String _subject;
  String get subject => _subject;

  late bool _pass;
  bool get pass => _pass;

  String setDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  void setTestData(int percentage, String subject, bool isPass) {
    _percentage = percentage;
    _testDate = setDate();
    _pass = isPass;
    _subject = subject;
  }
}
