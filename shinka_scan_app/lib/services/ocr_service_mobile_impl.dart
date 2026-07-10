import 'dart:typed_data';
import 'ocr_service.dart';
import 'ocr_service_mobile.dart';

OcrService getOcrService() {
  return MobileOcrService();
}