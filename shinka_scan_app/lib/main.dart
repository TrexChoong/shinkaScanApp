// main.dart
import 'package:flutter/material.dart';
import 'screens/collection_screen.dart';
import 'screens/cards_screen.dart';
import 'screens/boosters_screen.dart';
import 'screens/ocr_scan_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shinka Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const CollectionScreen(),
    const CardsScreen(),
    const BoostersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToOcrScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OcrScanScreen()),
    );
    // If using named routes:
    // Navigator.pushNamed(context, '/ocr');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shinka Scan'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Boosters',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent, 
        unselectedItemColor: Colors.grey, 
        onTap: _onItemTapped,
      ),
            // --- FloatingActionButton for OCR ---
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToOcrScreen,
        tooltip: 'Scan Card',
        child: const Icon(Icons.camera_alt),
        // backgroundColor: Colors.blueAccent, // Optional: customize color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Optional: if you want it docked
      // If using centerDocked, you might want to adjust the BottomAppBar shape
      // For example, if you also had a BottomAppBar:
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 6.0,
      //   child: BottomNavigationBar(...), // Your existing BottomNavigationBar
      // ),
    );
  }
}