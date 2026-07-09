import 'dart:typed_data';
import 'ocr_service.dart';
import 'ocr_service_stub.dart'; // To reuse the StubOcrService

OcrService getOcrService() {
  return StubOcrService();
}