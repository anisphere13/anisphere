// PhotoScreen de debug pour AniSphère.
// Affiche les photos locales enregistrées via PhotoProvider.


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/photo_provider.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final photos = context.watch<PhotoProvider>().photos;
    return Scaffold(
      appBar: AppBar(title: const Text('Photos locales')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return Image.file(File(photo.localPath), fit: BoxFit.cover);
        },
      ),
    );
  }
}
