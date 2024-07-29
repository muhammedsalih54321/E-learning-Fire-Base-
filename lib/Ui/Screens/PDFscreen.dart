
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfscreen extends StatefulWidget {
  final String pdf;
  const Pdfscreen({super.key, required this.pdf});

  @override
  State<Pdfscreen> createState() => _PdfscreenState();
}

class _PdfscreenState extends State<Pdfscreen> {
  
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(child: SfPdfViewer.network(widget.pdf))
    
    );
  }
  
 
}
