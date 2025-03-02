import 'package:education_app/resources/exports.dart';
import 'package:intl/intl.dart';

import '../../model/previous_test_report_model.dart';

class PreviousTestProvider with ChangeNotifier {
  String? _date;
  String? get date => _date;

  int? _percentage;
  int? get percentage => _percentage;

  String? _subject;
  String? get subject => _subject;

  bool? _pass;
  bool? get pass => _pass;

  String setDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  Future<void> setTestData(int percentage, String subject, bool isPass) async {
    _percentage = percentage;
    _date = setDate();
    _pass = isPass;
    _subject = subject;

    String status = isPass ? "Pass" : "Fail";

    var box = Hive.box<PreviousTestReportModel>('previousTests');
    await box.add(PreviousTestReportModel(
      date: _date!,
      percentage: _percentage!,
      status: status,
      subject: _subject!,
    ));

    notifyListeners();
  }
  Future<void> deleteAllTests() async {
    var box = Hive.box<PreviousTestReportModel>('previousTests');
    await box.clear(); // Clears all stored data

    notifyListeners();
  }
}
