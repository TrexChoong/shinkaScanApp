import 'dart:js_interop';

@JS('startWebCameraAndCapture')
external JSPromise<JSString?> _startWebCameraAndCaptureJs();

@JS('stopWebCamera')
external void _stopWebCameraJs();

Future<String?> startWebCameraAndCapture() async {
  final JSString? jsBase64Image = await (_startWebCameraAndCaptureJs() as JSPromise<JSString?>).toDart;
  return jsBase64Image?.toDart;
}

void stopWebCamera() {
  _stopWebCameraJs();
}
