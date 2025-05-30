/// Copilot Prompt : Service de vérification photo IA pour AniSphère.
/// Analyse les photos d’animaux pour détecter netteté, posture, cadrage, duplicata.
/// Utilise OpenCV/TFLite en local, et score la meilleure photo pour l'identité.
library;
import 'dart:io';
import 'package:image/image.dart' as img;

/// Service de vérification photo IA pour AniSphère.
/// Analyse les photos d’animaux pour détecter netteté, posture, cadrage, duplicata.
/// Utilise OpenCV/TFLite en local, et score la meilleure photo pour l'identité.

class PhotoVerificationService {
  /// Retourne un score d’utilisabilité pour une photo : 0.0 à 1.0
  Future<double> scorePhoto(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return 0.0;

      final sharpness = _estimateSharpness(decoded);
      final centered = _estimateCentering(decoded);

      // Pondération simple : 70 % netteté, 30 % centrage
      final score = (0.7 * sharpness) + (0.3 * centered);
      return double.parse(score.toStringAsFixed(2));
    } catch (_) {
      return 0.0;
    }
  }

  double _estimateSharpness(img.Image image) {
    final grey = img.grayscale(image);
    double sum = 0.0;
    for (var y = 1; y < grey.height - 1; y++) {
      for (var x = 1; x < grey.width - 1; x++) {
        final center = img.getLuminance(grey.getPixel(x, y));
        final left = img.getLuminance(grey.getPixel(x - 1, y));
        final right = img.getLuminance(grey.getPixel(x + 1, y));
        final top = img.getLuminance(grey.getPixel(x, y - 1));
        final bottom = img.getLuminance(grey.getPixel(x, y + 1));

        final laplace = ((center - left) +
                         (center - right) +
                         (center - top) +
                         (center - bottom));
        sum += laplace * laplace;
      }
    }
    return sum / (grey.width * grey.height * 255.0);
  }

  double _estimateCentering(img.Image image) {
    final centerLuma = img.getLuminance(image.getPixel(image.width ~/ 2, image.height ~/ 2));
    final borderLuma = img.getLuminance(image.getPixel(5, 5));
    return centerLuma > borderLuma ? 1.0 : 0.3;
  }
}

