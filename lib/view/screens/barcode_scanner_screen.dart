import 'package:attendance/controller/attendance/attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  Barcode? _qr;
  bool isScan = false;

  @override
  void initState() {
    super.initState();
    isScan = false;
  }

  void _takeAttendance() {
    if (!isScan) {
      isScan = true;
      Navigator.pop(context);
      AttendanceCubit.get(context).takeAttendance(_qr!.displayValue);
    }
  }

  void _handleQrCode(BarcodeCapture qrCodes) {
    if (mounted) {
      _qr = qrCodes.barcodes.firstOrNull;
      if (_qr != null) {
        _takeAttendance();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleQrCode,
          ),
        ],
      ),
    );
  }
}
