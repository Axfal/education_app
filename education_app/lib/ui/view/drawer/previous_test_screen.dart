import 'package:education_app/resources/exports.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PreviousTestScreen extends StatefulWidget {
  const PreviousTestScreen({super.key});

  @override
  State<PreviousTestScreen> createState() => _PreviousTestScreenState();
}

class _PreviousTestScreenState extends State<PreviousTestScreen> {
  List<List<String>> testData = [
    ["2025-01-30", "Mathematics", "89%", "Pass"],
    ["2025-01-29", "Physics", "35%", "Fail"],
    ["2025-01-28", "Chemistry", "70%", "Pass"],
    ["2025-01-27", "English", "83%", "Pass"],
    ["2025-01-26", "Biology", "41%", "Fail"],
  ];

  Future<void> saveTestReportAsPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text("Previous Tests Report",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ["Date", "Subject", "Percentage", "Status"],
                data: testData,
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration:
                    pw.BoxDecoration(color: PdfColors.blueGrey800),
                cellAlignment: pw.Alignment.center,
              ),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/previous_tests_report.pdf");

    await file.writeAsBytes(await pdf.save());

    if (kDebugMode) {
      print("PDF Saved at: ${file.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Previous Tests Report",
          style: AppTextStyle.appBarText,
        ),
        actions: [
          IconButton(
              onPressed: () {
                saveTestReportAsPdf();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("PDF Downloaded Successfully")),
                );
              },
              icon: Icon(
                Icons.download,
                color: Colors.white,
              )),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => AppColors.primaryColor),
                    border:
                        TableBorder.all(color: Colors.grey.shade300, width: 1),
                    columns: [
                      DataColumn(
                          label: Text("Date", style: AppTextStyle.drawerText)),
                      DataColumn(
                          label:
                              Text("Subject", style: AppTextStyle.drawerText)),
                      DataColumn(
                          label: Text("Percentage",
                              style: AppTextStyle.drawerText)),
                      DataColumn(
                          label:
                              Text("Status", style: AppTextStyle.drawerText)),
                    ],
                    rows: testData
                        .map((data) =>
                            _buildRow(data[0], data[1], data[2], data[3]))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
      String date, String subject, String percentage, String status) {
    return DataRow(
      cells: [
        DataCell(Text(date)),
        DataCell(Text(subject)),
        DataCell(Text(percentage)),
        DataCell(Text(
          status,
          style: TextStyle(
            color: status == "Pass" ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        )),
      ],
    );
  }
}
