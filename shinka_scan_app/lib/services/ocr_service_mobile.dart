import 'dart:io';
import 'dart:typed_data';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'ocr_service.dart';

class MobileOcrService implements OcrService {
  TextRecognizer? _textRecognizer;

  @override
  Future<void> initialize() async {
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  }

  @override
  Future<String?> recognizeTextFromImage(Uint8List imageData) async {
    if (_textRecognizer == null) {
      await initialize();
    }
    if (_textRecognizer == null) return null;

    try {
      // Create a temporary file to hold the image bytes for mlkit
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_ocr_image.jpg');
      await tempFile.writeAsBytes(imageData);

      final inputImage = InputImage.fromFilePath(tempFile.path);
      final RecognizedText recognizedText = await _textRecognizer!.processImage(inputImage);
      
      // Clean up the temp file
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      return recognizedText.text;
    } catch (e) {
      print("Error during Mobile OCR: $e");
      return null;
    }
  }

  @override
  void dispose() {
    _textRecognizer?.close();
  }
}