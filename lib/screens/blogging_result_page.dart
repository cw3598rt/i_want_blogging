import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BloggingResultScreen extends StatefulWidget {
  BloggingResultScreen({
    super.key,
  });

  @override
  State<BloggingResultScreen> createState() => _BloggingResultScreenState();
}

class _BloggingResultScreenState extends State<BloggingResultScreen> {
  String? directoryPath;

  void extractPdf(String response) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(response),
          ); // Center
        })); //
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    File("${appDir.path}/myPdf.pdf").writeAsBytes(await pdf.save());

    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
            title: Text("Saved as PDF"),
            content: Text("Saved at ${appDir.path}/myPdf.pdf"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Okay"),
              ),
            ]),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Saved as PDF"),
          content: Text("Saved at ${appDir.path}/myPdf.pdf"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogging By AI"),
        backgroundColor: Colors.yellowAccent.shade100,
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.yellowAccent.shade100, Colors.orange.shade100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: ListView(children: [
          GeminiResponseTypeView(
            builder: (context, child, response, loading) {
              if (loading) {
                return CircularProgressIndicator();
              }

              if (response != null) {
                return Column(
                  children: [
                    MarkdownBlock(data: response),
                    if (Platform.isAndroid || Platform.isIOS)
                      ElevatedButton.icon(
                          onPressed: () => extractPdf(response),
                          icon: Icon(Icons.picture_as_pdf),
                          label: Text("save as pdf")),
                  ],
                );
              } else {
                /// idle state
                return const Center(child: Text('Search something!'));
              }
            },
          ),
        ]),
      ),
    );
  }
}
