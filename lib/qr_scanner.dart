import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  final String empresa;

  const QRScannerPage({super.key, required this.empresa});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late MobileScannerController controller;
  bool scanned = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (scanned) return;

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final codigo = barcodes.first.rawValue ?? '';
      setState(() => scanned = true);
      controller.stop();

      Navigator.pushNamed(context, '/observacionForm', arguments: {
        'id': codigo,
        'empresa': widget.empresa,
        'ubicacion': 'Desconocida',
        'inspeccionado': false,
        'observacion': '',
        'fecha': '',
      }).then((_) {
        setState(() => scanned = false);
        controller.start(); // Reanudar cámara al volver
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear QR - ${widget.empresa}')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
            fit: BoxFit.cover,
          ),
          // Overlay similar a QrScannerOverlayShape
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: const Text('Cancelar'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
