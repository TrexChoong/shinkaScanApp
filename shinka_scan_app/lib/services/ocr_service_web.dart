// lib/services/web_ocr_interop.dart

import 'dart:js_interop'; // Core JS interop library
import 'dart:typed_data'; // For Uint8List

// Define the Tesseract global object
@JS('Tesseract') // Assuming Tesseract is a global object
@staticInterop
class _Tesseract {}

// Extend the _Tesseract object with the 'recognize' method
extension TesseractExtension on _Tesseract {
  external JSPromise<JSObject> recognize(
    JSAny image, // Can be Uint8List.toJS, or other image sources Tesseract accepts
    JSString language,
    JSObject options,
  );
}

// Getter for the global Tesseract object
@JS('Tesseract')
external _Tesseract get tesseract; // Allows you to call: tesseract.recognize(...)

// ---- Extension Types for Tesseract.js Options and Results for Type Safety ----

// For Tesseract.js options (e.g., the logger)
extension type TesseractOptions._(JSObject _) implements JSObject {
  external factory TesseractOptions({
    JSFunction? logger,
    // You can add other Tesseract.js options here as needed:
    // JSString? workerPath,
    // JSString? corePath,
    // JSString? langPath,
  });
  // External getters/setters if you need to read/write specific options
  // external JSFunction? get logger;
  // external set logger(JSFunction? f);
}

// For the overall recognition result structure (e.g., result.data.text)
extension type RecognitionResult._(JSObject _) implements JSObject {
  external RecognitionData? get data;
}

extension type RecognitionData._(JSObject _) implements JSObject {
  external JSString? get text;
  // You can add other fields like words, lines, confidence etc., as needed
  // external JSArray? get words;
  // external JSArray? get lines;
  // external JSNumber? get confidence;
}

// Example for progress object from Tesseract.js logger
extension type TesseractProgress._(JSObject _) implements JSObject {
  external JSString? get status;
  external JSNumber? get progress;
  external JSString? get workerId; // Example, check Tesseract.js docs for exact fields
}

// --- The main OCR function using js_interop ---

/// Performs OCR on an image using Tesseract.js via dart:js_interop.
///
/// [imageData]: The image data as Uint8List.
/// [lang]: The language code(s) for OCR (e.g., 'eng', 'eng+jpn').
/// [onProgress]: Optional callback for progress updates.
///   - `status`: A string describing the current OCR stage.
///   - `progress`: A double value from 0.0 to 1.0 indicating completion.
Future<String?> recognizeTextOnWeb(
  Uint8List imageData, {
  String lang = 'eng',
  Function(String status, double progress)? onProgress,
}) async {
  try {
    // Create the logger callback JSFunction
    final JSFunction loggerCallback = ((JSAny progressData) {
      if (onProgress != null) {
        // Cast progressData to our extension type for safer access
        final TesseractProgress progress = progressData as TesseractProgress;
        final status = progress.status?.toDart;
        final progressValue = progress.progress?.toDartDouble;

        if (status != null && progressValue != null) {
          onProgress(status, progressValue);
        }
      }
    }).toJS; // Convert the Dart closure to a JSFunction

    // Create Tesseract options
    final options = TesseractOptions(logger: loggerCallback);

    // Convert Dart Uint8List to JSAny (which will be seen as a Uint8Array or similar by JS)
    final jsImage = imageData.toJS;
    final jsLang = lang.toJS;

    // Call Tesseract.recognize
    final JSPromise<JSObject> promise = tesseract.recognize(
      jsImage,
      jsLang,
      options, // Pass the JSObject directly
    );

    // Await the promise and get the result
    final JSObject? jsResult = await promise.toDart;

    if (jsResult != null) {
      // Use the extension type to access data safely
      final RecognitionResult result = jsResult as RecognitionResult;
      return result.data?.text?.toDart;
    }
    return null;
  } catch (e) {
    print('Error during web OCR: ${e.toString()}');
    if (e is Exception) {
      // Exception often contains more details from the JavaScript side
      print('Exception message: ${e.toString()}');
    }
    return null;
  }
}