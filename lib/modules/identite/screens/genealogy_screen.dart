import 'package:flutter/material.dart';
import '../../../theme.dart';
import 'dart:io';
import '../services/genealogy_pdf_ocr_service.dart';
import '../models/genealogy_model.dart';

class GenealogyScreen extends StatefulWidget {
  const GenealogyScreen({super.key});

  @override
  State<GenealogyScreen> createState() => _GenealogyScreenState();
}

class _GenealogyScreenState extends State<GenealogyScreen> {
  GenealogyModel? genealogy;
  bool duplicateAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Généalogie')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (duplicateAlert)
              const Text(
                'Doublon potentiel détecté',
                style: TextStyle(color: primaryBlue),
              ),
            const SizedBox(height: 8),
            if (genealogy != null) _buildGraph(),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _importPdf, child: const Text('Importer PDF')),
          ],
        ),
      ),
    );
  }

  Widget _buildGraph() {
    return Column(
      children: [
        Text(genealogy!.fatherName ?? '?'),
        const Icon(Icons.arrow_downward),
        Text(genealogy!.animalId),
        const Icon(Icons.arrow_downward),
        Text(genealogy!.motherName ?? '?'),
      ],
    );
  }

  Future<void> _importPdf() async {
    final temp = File('${Directory.systemTemp.path}/dummy.pdf');
    await temp.writeAsBytes([]);
    final data = await GenealogyPdfOcrService().extractGenealogyData(temp);
    final map = {'animalId': 'A1'}..addAll(data);
    setState(() {
      genealogy = GenealogyModel.fromMap(map);
      duplicateAlert = data['fatherName'] == data['motherName'];
    });
  }
}
