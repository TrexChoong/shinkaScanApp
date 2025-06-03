import 'dart:typed_data';

abstract class OcrService {
  /// Recognizes text from the given image data.
  /// Returns the recognized text as a String, or null if an error occurs or no text is found.
  Future<String?> recognizeTextFromImage(Uint8List imageData);

  /// Initializes any resources if needed (e.g., language models for Tesseract.js on web).
  Future<void> initialize();

  /// Disposes of any resources used by the OCR service.
  void dispose();
}