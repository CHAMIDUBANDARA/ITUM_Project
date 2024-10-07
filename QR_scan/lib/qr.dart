import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const QRCodeScreen(),
      routes: {
        '/page1': (context) => const Page1(),
        '/page2': (context) => const Page2(),
        // Add more routes here as needed
      },
    );
  }
}

/// The main screen that displays the QR scanner.
class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _scanned = false; // Prevent multiple scans
  String qrText = 'Scan a QR Code';

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        controller!.pauseCamera();
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.orange,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                qrText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Called when the QRView is created.
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!_scanned) {
        setState(() {
          qrText = scanData.code ?? 'No Data Found';
          _scanned = true; // Prevent multiple scans
        });

        // Process the scanned data
        _processScannedData(qrText);
      }
    });
  }

  /// Processes the scanned QR code data.
  void _processScannedData(String data) {
    // Check if the data is a valid URL
    Uri? uri = Uri.tryParse(data);
    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      _launchURL(uri);
    } else {
      // Handle as internal navigation
      _navigateToInternalPage(data);
    }
  }

  /// Launches a URL in the device's default browser.
  Future<void> _launchURL(Uri url) async {
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        _showErrorDialog('Could not launch ${url.toString()}');
      }
    } catch (e) {
      _showErrorDialog('Error launching URL: ${e.toString()}');
    }
  }

  /// Navigates to internal pages based on the scanned data.
  void _navigateToInternalPage(String routeName) {
    // Define your route names accordingly
    String route = '/$routeName';

    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }

    // Check if the route exists
    if (_routeExists(route)) {
      Navigator.pushNamed(context, route);
    } else {
      _showErrorDialog('Unknown QR Code: $routeName');
      setState(() {
        _scanned = false; // Reset scan state to allow re-scanning
      });
    }
  }

  /// Checks if a given route exists in the app.
  bool _routeExists(String routeName) {
    var containsKey = (Navigator.of(context).widget as MaterialApp)
        .routes
        ?.containsKey(routeName);
    return Navigator.of(context).widget is MaterialApp && containsKey!;
  }

  /// Displays an error dialog with the provided message.
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _scanned = false; // Reset scan state to allow re-scanning
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
    controller?.dispose();
    super.dispose();
  }
}

/// Sample Page1 widget.
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Welcome to Page 1!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

/// Sample Page2 widget.
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Welcome to Page 2!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
