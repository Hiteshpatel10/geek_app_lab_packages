import 'dart:io';
import 'package:core_calculator/loan_calculator/functions/emi_function.dart';
import 'package:core_utility/extensions/currency_formatter/inr_formatter.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

Future<void> emiPDFReport(CoreReportModel<CoreEMIReportModel> report) async {
  final pdf = pw.Document();

  // Load custom font
  final fontData = await rootBundle.load('packages/core_calculator/assets/fonts/Roboto-Regular.ttf');
  final ttf = pw.Font.ttf(fontData);

  // Add a cover page
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              "EMI Report",
              style: pw.TextStyle(
                fontSize: 32,
                fontWeight: pw.FontWeight.bold,
                font: ttf,  // Apply custom font
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Text(
              "Generated on: ${DateTime.now().toLocal()}",
              style: pw.TextStyle(
                fontSize: 16,
                color: PdfColors.grey600,
                font: ttf,  // Apply custom font
              ),
            ),
            pw.SizedBox(height: 32),
            pw.Text(
              "EMI Calculator",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex(colorToHex(CoreColors.toryBlue)),
                font: ttf,  // Apply custom font
              ),
            ),
          ],
        );
      },
    ),
  );

  // Add content pages
  for (var index = 0; index < report.monthlyReport.length; ++index) {
    final monthlyReport = report.monthlyReport[index];
    final yearlyReport = report.yearlyReport[index];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Section Header
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                color: PdfColor.fromHex(colorToHex(CoreColors.toryBlue)),
                child: pw.Text(
                  "Year ${index + 1} Summary",
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,  // Apply custom font
                  ),
                ),
              ),
              pw.SizedBox(height: 16),

              // Yearly summary table
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Principal Paid:", style: pw.TextStyle(font: ttf)),
                        pw.Text(
                          format2INR(yearlyReport.principalRepayment),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Interest Paid:", style: pw.TextStyle(font: ttf)),
                        pw.Text(
                          format2INR(yearlyReport.interest),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Remaining Balance: ₹", style: pw.TextStyle(font: ttf)),
                        pw.Text(
                          format2INR(yearlyReport.principleOutstanding),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),

              // Monthly Report Table
              pw.Text(
                "Monthly Breakdown",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  font: ttf,  // Apply custom font
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: const pw.FixedColumnWidth(50),
                  1: const pw.FlexColumnWidth(),
                  2: const pw.FlexColumnWidth(),
                  3: const pw.FlexColumnWidth(),
                },
                children: [
                  // Table Header
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Month", textAlign: pw.TextAlign.center, style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Principal Paid", textAlign: pw.TextAlign.center, style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Interest Paid", textAlign: pw.TextAlign.center, style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text("Balance", textAlign: pw.TextAlign.center, style: pw.TextStyle(font: ttf)),
                      ),
                    ],
                  ),
                  // Data Rows
                  ...List.generate(
                    monthlyReport.length,
                        (monthIndex) {
                      final investValueModel = monthlyReport[monthIndex];
                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              (monthIndex + 1).toString(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(font: ttf),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(format2INR(investValueModel.principalRepayment), style: pw.TextStyle(font: ttf)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(format2INR(investValueModel.interest), style: pw.TextStyle(font: ttf)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(format2INR(investValueModel.principleOutstanding), style: pw.TextStyle(font: ttf)),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/emi_report.pdf';

  // Save the file
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  final result = await OpenFile.open(filePath);
  print('PDF saved at $filePath');
}
