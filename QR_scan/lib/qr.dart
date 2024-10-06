import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = 'Scan a QR Code';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Action to navigate back
          },
        ),
        title: const Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/passenger.png'), // Add your avatar image here
              radius: 22,
            ),
            SizedBox(width: 10),
            Text(
              'UserName',
              style: TextStyle( // Use TextStyle to define the text's font weight
                fontWeight: FontWeight.bold, // Correct way to set font weight
                fontSize: 22, // Add font size if necessary
              ),
              strutStyle: StrutStyle(
                fontSize: 20, // Optional: Customize the strutStyle if needed
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.menu),iconSize: 22,
            onPressed: () {
              // Add menu functionality here
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Display the QR scanner preview
          Expanded(
            flex: 4,
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
                style: const TextStyle(fontSize: 20,fontWeight:FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        onTap: (index) {
          // Handle navigation tap
        },
      ),*/
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
