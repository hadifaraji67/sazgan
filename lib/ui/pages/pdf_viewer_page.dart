import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfViewerPage extends StatelessWidget {
  final String assetPath;
  const PdfViewerPage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نمایش PDF'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: PdfViewer.asset(assetPath),
    );
  }
}
