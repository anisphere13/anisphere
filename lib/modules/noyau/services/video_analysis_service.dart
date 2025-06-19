// Copilot Prompt : VideoAnalysisService analyses pet training videos locally.
// Videos are deleted right after processing and never uploaded to Firebase.
// Only anonymized AI results are sent to logs_ia/ for improvement.

class VideoAnalysisService {
  Future<Map<String, dynamic>> analyzeVideo(String path) async {
    // TODO: implement call to TFLite model.
    // After processing, delete the video file from local storage.
    return {'score': 0};
  }
}
