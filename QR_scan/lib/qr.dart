// Importing necessary Flutter packages for building the app, QR code scanning, and launching URLs.
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

// This is where the app starts.
void main() {
  runApp(const MyApp());
}

/// The main widget of the app, which is stateless (doesn't change after being built).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define how the app looks and feels (theme) and set the home screen (QR code scanner).
    return MaterialApp(
      title: 'Flutter QR Scanner', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.orange, // Use orange as the main color theme
      ),
      home:
          const QRCodeScreen(), // The first screen when the app starts (QR scanner)
      routes: {
        '/page1': (context) => const Page1(), // Route for Page1
        '/page2': (context) => const Page2(), // Route for Page2
        // You can add more screens here if needed
      },
    );
  }
}

/// This widget is for the main screen where the QR code scanner will be displayed.
class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

/// The state class for QRCodeScreen, which handles the scanning logic.
class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey =
      GlobalKey(debugLabel: 'QR'); // A unique key for the QR scanner
  QRViewController? controller; // Controller for managing the QR scanner
  bool _scanned = false; // This variable prevents multiple scans
  String qrText = 'Scan a QR Code'; // The text shown before scanning

  // This method is called when the app is rebuilt, like when switching between apps.
  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      // Pause or resume the camera based on the device platform (Android/iOS)
      if (Theme.of(context).platform == TargetPlatform.android) {
        controller!.pauseCamera();
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // The layout of the screen with an app bar and the QR scanner.
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'), // Title in the app bar
        backgroundColor: Colors.orange, // App bar color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button in the app bar
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5, // This part takes 5/6 of the screen
            child: QRView(
              key: qrKey, // Unique key for the QR scanner
              onQRViewCreated:
                  _onQRViewCreated, // Function called when QRView is ready
              overlay: QrScannerOverlayShape(
                borderColor: Colors.orange, // QR scan area border color
                borderRadius: 10, // Rounded corners
                borderLength: 30, // Length of the border
                borderWidth: 10, // Thickness of the border
                cutOutSize: 300, // Size of the square scan area
              ),
            ),
          ),
          Expanded(
            flex: 1, // This part takes 1/6 of the screen
            child: Center(
              child: Text(
                qrText, // Display the scanned text
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// This method is called when the QRView is ready to be used.
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    // Listen for QR code scanning results
    controller.scannedDataStream.listen((scanData) {
      if (!_scanned) {
        // Only handle the first scan
        setState(() {
          qrText = scanData.code ??
              'No Data Found'; // Update UI with the scanned data
          _scanned = true; // Prevent further scans
        });

        // Process the scanned data (e.g., if it's a URL, open it)
        _processScannedData(qrText);
      }
    });
  }

  /// This method processes the scanned data.
  void _processScannedData(String data) {
    // Check if the scanned data is a valid URL
    Uri? uri = Uri.tryParse(data);
    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      _launchURL(uri); // If it's a URL, open it in the browser
    } else {
      // Otherwise, treat it as an internal route (like navigating to a page in the app)
      _navigateToInternalPage(data);
    }
  }

  /// This method opens a URL in the browser.
  Future<void> _launchURL(Uri url) async {
    try {
      // Try to open the URL in an external browser
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        _showErrorDialog(
            'Could not launch ${url.toString()}'); // Show an error if it fails
      }
    } catch (e) {
      _showErrorDialog(
          'Error launching URL: ${e.toString()}'); // Show an error if an exception occurs
    }
  }

  /// This method navigates to a different page within the app based on the scanned data.
  void _navigateToInternalPage(String routeName) {
    // Convert the scanned data into a route name
    String route = '/$routeName';

    if (Navigator.of(context).canPop()) {
      Navigator.pop(context); // Go back if possible
    }

    // Check if the route exists in the app
    if (_routeExists(route)) {
      Navigator.pushNamed(context, route); // Navigate to the page if it exists
    } else {
      _showErrorDialog(
          'Unknown QR Code: $routeName'); // Show an error if the route is unknown
      setState(() {
        _scanned = false; // Allow re-scanning
      });
    }
  }

  /// This method checks if the given route exists in the app's routes.
  bool _routeExists(String routeName) {
    var containsKey = (Navigator.of(context).widget as MaterialApp)
        .routes
        ?.containsKey(routeName); // Check if the route is defined
    return Navigator.of(context).widget is MaterialApp && containsKey!;
  }

  /// This method shows a dialog with an error message.
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'), // Title of the dialog
          content: Text(message), // Error message
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  _scanned =
                      false; // Allow re-scanning after the dialog is closed
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose(); // Dispose of the controller to release resources
    super.dispose();
  }
}

/// A sample page (Page 1) that the user can navigate to.
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'), // Title of Page 1
        backgroundColor: Colors.orange, // App bar color
      ),
      body: const Center(
        child: Text(
          'Welcome to Page 1!', // Text displayed on Page 1
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

/// Another sample page (Page 2) that the user can navigate to.
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'), // Title of Page 2
        backgroundColor: Colors.orange, // App bar color
      ),
      body: const Center(
        child: Text(
          'Welcome to Page 2!', // Text displayed on Page 2
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
