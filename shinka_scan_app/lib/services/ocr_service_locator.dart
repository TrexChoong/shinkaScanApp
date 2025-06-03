export 'ocr_service_stub.dart' // Default/Stub implementation
    if (dart.library.io) 'ocr_service_mobile_impl.dart' // For mobile (uses dart:io)
    if (dart.library.html) 'ocr_service_web_impl.dart'; // For web (uses dart:html)