import 'dart:typed_data';
import 'ocr_service.dart'; 
import 'ocr_service_web_interop.dart'; 

OcrService getOcrService() {
  return WebOcrService();
}

class WebOcrService implements OcrService {
  String _currentStatus = "";
  double _currentProgress = 0.0;

  @override
  Future<void> initialize() async {
    // Tesseract.js usually initializes when its script is loaded via index.html.
    // You could add checks here if Tesseract.js provides an API for readiness,
    // or pre-load language data/workers if you want more control.
    print("WebOcrService initialized (Tesseract.js should be ready).");
  }

  @override
  Future<String?> recognizeTextFromImage(Uint8List imageData) async {
    // Reset progress for new recognition
    _currentStatus = "Starting OCR...";
    _currentProgress = 0.0;
    // You might want a way to report progress back to the UI if needed.
    // For this example, we'll just print it.

    return await recognizeTextOnWeb(
      imageData,
      lang: 'eng', // Or make this configurable
      onProgress: (status, progress) {
        _currentStatus = status;
        _currentProgress = progress;
        print('OCR Progress: $status - ${(progress * 100).toStringAsFixed(0)}%');
        // If you have a stream/callback to update UI progress, use it here.
      },
    );
  }

  @override
  void dispose() {
    // For Tesseract.js, if you've manually created workers, you might terminate them.
    // If using the simple API as above, often no explicit Dart-side dispose needed for Tesseract itself.
    print("WebOcrService disposed.");
  }

  // Optional: Method to get current progress if your UI needs to poll it
  Map<String, dynamic> getCurrentProgress() {
    return {'status': _currentStatus, 'progress': _currentProgress};
  }
}