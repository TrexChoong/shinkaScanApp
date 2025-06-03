import 'dart:typed_data';
import 'ocr_service.dart';

OcrService getOcrService() {
  return StubOcrService();
}

class StubOcrService implements OcrService {
  @override
  Future<void> initialize() async {
    print("StubOcrService initialized: OCR not supported on this platform.");
  }

  @override
  Future<String?> recognizeTextFromImage(Uint8List imageData) async {
    print("StubOcrService: OCR not supported.");
    throw UnimplementedError('OCR not supported on this platform');
  }

  @override
  void dispose() {
    print("StubOcrService disposed.");
  }
}