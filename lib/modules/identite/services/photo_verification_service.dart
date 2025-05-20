/// Copilot Prompt : Service de vérification photo IA pour AniSphère.
/// Analyse les photos d’animaux pour détecter netteté, posture, cadrage, duplicata.
/// Utilise OpenCV/TFLite en local, et score la meilleure photo pour l'identité.
import 'dart:io';
import 'package:image/image.dart' as img;

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
    // Filtre de Laplace simplifié
    final grey = img.grayscale(image);
    double sum = 0.0;
    for (var y = 1; y < grey.height - 1; y++) {
      for (var x = 1; x < grey.width - 1; x++) {
        final center = grey.getPixel(x, y) & 0xFF;
        final laplace = ((center - (grey.getPixel(x - 1, y) & 0xFF)) +
                         (center - (grey.getPixel(x + 1, y) & 0xFF)) +
                         (center - (grey.getPixel(x, y - 1) & 0xFF)) +
                         (center - (grey.getPixel(x, y + 1) & 0xFF)));
        sum += laplace * laplace;
      }
    }
    return sum / (grey.width * grey.height * 255.0);
  }

  double _estimateCentering(img.Image image) {
    // Détection simple : zone centrale plus claire que la périphérie ?
    final center = image.getPixel(image.width ~/ 2, image.height ~/ 2) & 0xFF;
    final border = image.getPixel(5, 5) & 0xFF;
    return center > border ? 1.0 : 0.3;
  }
}
