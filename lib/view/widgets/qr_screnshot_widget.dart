import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreenshotWidget extends StatelessWidget {
  const QrScreenshotWidget({
    super.key,
    required this.id,
    required this.name,
    // required this.teamId,
    // required this.subTeamId,
  });

  final String id;
  // final String teamId;
  // final String subTeamId;
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
            // data: 'user_id:$id,team_id:$teamId,sub_team_id:$subTeamId',
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
