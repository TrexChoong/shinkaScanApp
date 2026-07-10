// lib/screens/ocr_scan_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb for platform check
import 'dart:convert';

// Import the abstract service and the locator
import 'package:shinka_scan_app/services/ocr_service.dart'; 
import 'package:shinka_scan_app/services/ocr_service_locator.dart'; 
import 'package:shinka_scan_app/services/web_camera_interop.dart';
import 'package:shinka_scan_app/data/card_repository.dart';
import 'package:shinka_scan_app/models/TCGCard.dart';

class OcrScanScreen extends StatefulWidget {
  const OcrScanScreen({super.key});

  @override
  State<OcrScanScreen> createState() => _OcrScanScreenState();
}

class _OcrScanScreenState extends State<OcrScanScreen> {
  final OcrService _ocrService = getOcrService();
  final ImagePicker _picker = ImagePicker();

  String _status = "Press a button to initialize OCR Service.";
  String? _fullRecognizedText;
  String? _extractedCardId;
  Uint8List? _pickedImageBytes;

  bool _isInitialized = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeOcr();
  }

  Future<void> _initializeOcr() async {
    if (_isInitialized) return;
    setState(() {
      _status = "Initializing OCR Service...";
      _isProcessing = true;
    });
    try {
      await _ocrService.initialize();
      setState(() {
        _status = "OCR Service Initialized. Pick an image or use camera.";
        _isInitialized = true;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _status = "Error initializing OCR: ${e.toString()}";
        _isProcessing = false;
      });
    }
  }

Future<void> _pickAndProcessImage(ImageSource source) async {
    if (!_isInitialized) {
      setState(() {
        _status = "OCR Service not initialized. Please wait or try again.";
      });
      await _initializeOcr();
      if (!_isInitialized) return;
    }

    setState(() {
      _status = source == ImageSource.camera ? "Opening camera..." : "Picking image from gallery...";
      _fullRecognizedText = null;
      _extractedCardId = null;
      _pickedImageBytes = null;
      _isProcessing = true;
    });

    try {
      Uint8List? capturedImageBytes;

      if (kIsWeb && source == ImageSource.camera) {
        // --- Web Camera Access via JavaScript Interop ---
        setState(() {
          _status = "Requesting camera access (web)...";
        });
        final String? base64Image = await startWebCameraAndCapture();

        if (base64Image != null && base64Image.isNotEmpty) {
          // Remove the "data:image/jpeg;base64," prefix if present
          final String base64Data = base64Image.split(',').last;
          capturedImageBytes = base64Decode(base64Data);
          setState(() {
            _status = "Image captured from webcam.";
          });
        } else {
          setState(() {
            _status = "Webcam capture cancelled or failed.";
            _isProcessing = false;
          });
          return;
        }
        // --- End Web Camera Access ---
      } else {
        // --- Standard Image Picker (for gallery on web, or camera/gallery on mobile) ---
        final XFile? imageFile = await _picker.pickImage(source: source);
        if (imageFile == null) {
          setState(() {
            _status = "Image selection/capture cancelled.";
            _isProcessing = false;
          });
          return;
        }
        capturedImageBytes = await imageFile.readAsBytes();
        // --- End Standard Image Picker ---
      }

      if (capturedImageBytes == null) {
        setState(() {
          _status = "Failed to get image bytes.";
          _isProcessing = false;
        });
        return;
      }

      setState(() {
        _pickedImageBytes = capturedImageBytes;
        _status = "Processing image for text (this may take a moment)...";
      });

      final String? text = await _ocrService.recognizeTextFromImage(capturedImageBytes);

      print("Full recognized text from OCR service: $text");

      if (text != null && text.isNotEmpty) {
        _fullRecognizedText = text;
        _extractedCardId = _extractCardId(text);
        if (_extractedCardId != null) {
          _status = "Card ID Found! Looking up in database...";
        } else {
          _status = "OCR Complete. Card ID pattern not found in recognized text.";
        }
      } else {
        _fullRecognizedText = "No text found by OCR or an error occurred during recognition.";
        _status = "OCR Failed or No Text Recognized.";
      }
      setState(() {
        _isProcessing = false;
      });

      if (_extractedCardId != null) {
         final matchResult = await cardRepository.searchCardsByFuzzyId(_extractedCardId!);
         if (!mounted) return;
         if (matchResult.exactMatch != null || matchResult.suggestions.isNotEmpty) {
           final bestMatch = matchResult.exactMatch ?? matchResult.suggestions.first;
           final otherSuggestions = matchResult.suggestions.where((c) => c.cardno != bestMatch.cardno).toList();
           _showConfirmationModal(bestMatch, otherSuggestions);
         } else {
           setState(() {
             _status = "Card ID $_extractedCardId not found in database.";
           });
         }
      }
    } catch (e) {
      setState(() {
        _fullRecognizedText = "Error during OCR process: ${e.toString()}";
        _status = "OCR Error.";
        _isProcessing = false;
      });
    } finally {
      // Ensure any active camera stream from JS interop is stopped if needed
      if (kIsWeb && source == ImageSource.camera) {
        stopWebCamera();
      }
    }
  }

  String? _extractCardId(String text) {
    final RegExp cardIdPattern = RegExp(r'\b([A-Z]{2,3}[0-9OI]{1,3}[-.]\d{3})\b', caseSensitive: true);
    String cleanedText = text.replaceAll('\n', ' ').replaceAll('\r', ' ');
    final Match? match = cardIdPattern.firstMatch(cleanedText);
    if (match != null && match.groupCount > 0) {
      String extractedId = match.group(1)!;
      extractedId.replaceAll('.', '-');
      extractedId.replaceAll('8', 'B');
      return extractedId;
    }
    return null;
  }

  void _showConfirmationModal(TCGCard exactMatch, List<TCGCard> suggestions) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Is this a match?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (exactMatch.imageUrl.isNotEmpty) 
                 Image.network(exactMatch.imageUrl, height: 150),
              const SizedBox(height: 10),
              Text(exactMatch.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(exactMatch.cardno),
            ],
          ),
          actions: <Widget>[
            if (suggestions.isNotEmpty)
              TextButton(
                child: const Text('Show other suggestions'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  _showSelectionModal(suggestions);
                },
              ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                print("User clicked Yes! Adding card ${exactMatch.name} (${exactMatch.cardno}) to collection...");
                Navigator.of(dialogContext).pop();
                try {
                  bool added = await cardRepository.addToCollection(exactMatch);
                  if (added) {
                    print("Successfully added to collection in database!");
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${exactMatch.name} added to your collection!')),
                      );
                    }
                  } else {
                    print("Card already in collection.");
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${exactMatch.name} is already in your collection.')),
                      );
                    }
                  }
                } catch (e) {
                  print("Error adding to collection: $e");
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add card: $e')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showSelectionModal(List<TCGCard> suggestions) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Did you mean?'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (BuildContext itemContext, int index) {
                final card = suggestions[index];
                return ListTile(
                  leading: card.imageUrl.isNotEmpty ? Image.network(card.imageUrl, width: 40) : const Icon(Icons.credit_card),
                  title: Text(card.name),
                  subtitle: Text(card.cardno),
                  onTap: () async {
                    print("User tapped suggestion! Adding card ${card.name} (${card.cardno}) to collection...");
                    Navigator.of(dialogContext).pop();
                    try {
                      bool added = await cardRepository.addToCollection(card);
                      if (added) {
                        print("Successfully added suggestion to collection in database!");
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${card.name} added to your collection!')),
                          );
                        }
                      } else {
                        print("Card already in collection.");
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${card.name} is already in your collection.')),
                          );
                        }
                      }
                    } catch (e) {
                      print("Error adding suggestion to collection: $e");
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add card: $e')),
                        );
                      }
                    }
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Card (OCR)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey[300]!)
                  ),
                  child: _pickedImageBytes != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(11.0),
                          child: Image.memory(_pickedImageBytes!, fit: BoxFit.contain),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_search, size: 60, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Image preview will appear here', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Row( // Using a Row for two buttons
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () => _pickAndProcessImage(ImageSource.gallery),
                    icon: _isProcessing && _status.contains("gallery") // Show progress only if this button was pressed
                        ? Container(
                            width: 20, height: 20,
                            child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.photo_library_outlined),
                    label: const Text("Pick from Gallery"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () => _pickAndProcessImage(ImageSource.camera),
                    icon: _isProcessing && _status.contains("camera") // Show progress only if this button was pressed
                        ? Container(
                            width: 20, height: 20,
                            child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.camera_alt_outlined),
                    label: const Text("Use Camera"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Status: $_status",
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (_extractedCardId != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Detected Card ID: $_extractedCardId",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]),
                    textAlign: TextAlign.center,
                  ),
                ),
              const Text(
                "Full Recognized Text (from OCR):",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade50,
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      _fullRecognizedText ?? "Text will appear here...",
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
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
