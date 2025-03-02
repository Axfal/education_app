// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:education_app/resources/exports.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../model/previous_test_report_model.dart';

class PreviousTestScreen extends StatefulWidget {
  const PreviousTestScreen({super.key});

  @override
  State<PreviousTestScreen> createState() => _PreviousTestScreenState();
}

class _PreviousTestScreenState extends State<PreviousTestScreen> {
  List<List<String>> testData = [];

  @override
  void initState() {
    super.initState();
    loadPreviousTests();
  }

  /// Fetch stored test data from Hive
  void loadPreviousTests() {
    var box = Hive.box<PreviousTestReportModel>('previousTests');
    setState(() {
      testData = box.values.map((test) {
        return [
          test.date,
          /*test.subject,*/ "${test.percentage}%",
          test.status
        ];
      }).toList();
    });
  }

  /// Generate and save the PDF report
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
                headers: ["Date", /*"Subject",*/ "Percentage", "Status"],
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF Downloaded Successfully at ${file.path}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreviousTestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Previous Tests Report",
          style: AppTextStyle.appBarText,
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'download') {
                saveTestReportAsPdf();
              } else if (value == 'delete') {
                await provider
                    .deleteAllTests(); // Wait until deletion is complete
                setState(() {
                  loadPreviousTests(); // Refresh the UI after deletion
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'download',
                child: Row(
                  children: [
                    Text("Download"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Text("Clear all"),
                  ],
                ),
              ),
            ],
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      body: testData.isEmpty
          ? Center(child: Text("No test data available"))
          : Column(
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
                          border: TableBorder.all(
                              color: Colors.grey.shade300, width: 1),
                          columns: [
                            DataColumn(
                                label: Text("Date",
                                    style: AppTextStyle.drawerText)),
                            // DataColumn(
                            //     label: Text("Subject",
                            //         style: AppTextStyle.drawerText)),
                            DataColumn(
                                label: Text("Percentage",
                                    style: AppTextStyle.drawerText)),
                            DataColumn(
                                label: Text("Status",
                                    style: AppTextStyle.drawerText)),
                          ],
                          rows: testData
                              .map((data) => _buildRow(
                                  data[0], /*data[1],*/ data[1], data[2]))
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
      String date, /*String subject,*/ String percentage, String status) {
    return DataRow(
      cells: [
        DataCell(Text(date)),
        // DataCell(Text(subject)),
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
