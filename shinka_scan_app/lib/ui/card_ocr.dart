import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

// Import the abstract service and the locator
import 'package:shinka_scan_app/services/ocr_service.dart';
import 'package:shinka_scan_app/services/ocr_service_locator.dart'; // This gets the correct implementation

class MyOcrPage extends StatefulWidget {
  @override
  _MyOcrPageState createState() => _MyOcrPageState();
}

class _MyOcrPageState extends State<MyOcrPage> {
  final OcrService _ocrService = getOcrService(); // Get the platform-specific service
  final ImagePicker _picker = ImagePicker();

  String _status = "Initialize OCR Service.";
  String? _recognizedText;
  Uint8List? _pickedImageBytes;
  
  bool _isInitialized = false; // Track initialization status
  bool _isProcessing = false; 

  @override
  void initState() {
    super.initState();
    _initializeOcr();
  }


  Future<void> _initializeOcr() async {
    if (_isInitialized) return; // Prevent re-initialization
    setState(() {
      _status = "Initializing OCR Service...";
      _isProcessing = true; // Indicate processing
    });
    try {
      await _ocrService.initialize();
      setState(() {
        _status = "OCR Service Initialized. Pick an image.";
        _isInitialized = true; // Set initialized to true
        _isProcessing = false; // End processing
      });
    } catch (e) {
      setState(() {
        _status = "Error initializing OCR: ${e.toString()}"; // Use toString for better error messages
        _isProcessing = false; // End processing
      });
    }
  }

  Future<void> _pickAndProcessImage(ImageSource source) async {
    setState(() {
      _status = source == ImageSource.camera ? "Opening camera..." : "Picking image from gallery...";
      _recognizedText = null;
      _pickedImageBytes = null;
    });
    setState(() {
      _status = source == ImageSource.camera ? "Opening camera..." : "Picking image from gallery...";
      _recognizedText = null;
      _pickedImageBytes = null;
      _isProcessing = true; // Indicate processing
    });

    try {
      final XFile? imageFile = await _picker.pickImage(source: source);
      if (imageFile == null) {
        setState(() {
          _status = "Image selection cancelled.";
          _isProcessing = false; // End processing
        });
        return;
      }

      final Uint8List imageBytes = await imageFile.readAsBytes();
      setState(() {
        _pickedImageBytes = imageBytes;
        _status = "Processing image...";
      });

      final String? text = await _ocrService.recognizeTextFromImage(imageBytes);

      setState(() {
        if (text != null && text.isNotEmpty) {
          _recognizedText = text;
          _status = "OCR Complete.";
        } else {
          _recognizedText = "No text found or error during OCR.";
          _status = "OCR Failed or No Text.";
        }
        _isProcessing = false; // End processing
      });
    } catch (e) {
      setState(() {
        _recognizedText = "Error during OCR process: ${e.toString()}";
        _status = "OCR Error.";
        _isProcessing = false; // End processing
      });
    }
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cross-Platform OCR")),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : () => _pickAndProcessImage(ImageSource.gallery),
                      icon: _isProcessing && _status.contains("gallery") // Show progress only if this button was pressed
                          ? const SizedBox( // Added const
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white), // Added const
                            )
                          : const Icon(Icons.photo_library_outlined), // Added const
                      label: const Text("Pick from Gallery"), // Added const
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15), // Adjusted padding
                        textStyle: const TextStyle(fontSize: 14), // Added const
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Space between buttons
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : () => _pickAndProcessImage(ImageSource.camera),
                      icon: _isProcessing && _status.contains("camera") // Show progress only if this button was pressed
                          ? const SizedBox( // Added const
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white), // Added const
                            )
                          : const Icon(Icons.camera_alt_outlined), // Added const
                      label: const Text("Use Camera"), // Added const
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15), // Adjusted padding
                        textStyle: const TextStyle(fontSize: 14), // Added const
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
          ),
        ),
      ),
    );
  }
}