import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizador de PDF'),
      ),
      body: FutureBuilder(
        future: _loadPdf(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao abrir o PDF'),
              );
            } else {
              return PDFViewer(document: snapshot.data as PDFDocument);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<PDFDocument> _loadPdf() async {
    try {
      PDFDocument document = await PDFDocument.fromURL(pdfUrl);
      return document;
    } catch (e) {
      print('Erro ao abrir o PDF: $e');
      throw e;
    }
  }
}
