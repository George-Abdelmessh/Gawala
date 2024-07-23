import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrScreenshotWidget extends StatelessWidget {
  const QrScreenshotWidget({
    super.key,
    required this.id,
    required this.name,
  });

  final String id;
  final String name;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: QrImageView(
            data: id,
            size: 320,
            version: QrVersions.auto,
            gapless: false,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
