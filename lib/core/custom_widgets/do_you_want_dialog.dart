import 'package:flutter/material.dart';
import '../style/app_colors.dart';

class DoYouWantDialog extends StatelessWidget {
  const DoYouWantDialog({
    super.key,
    required this.title,
    required this.deletedItem,
    required this.whenYesTap,
  });

  final String title;
  final String deletedItem;
  final Function() whenYesTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          deletedItem,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.lightGrey,
              fontSize: 14),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _button(
                text: 'Yes,delete',
                bgColor: Colors.red,
                icon: Icons.delete_forever,
                onTap: () => whenYesTap(),
                textColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _button(
                text: 'No,cancel',
                bgColor: AppColors.lightGrey.withOpacity(0.4),
                textColor: Colors.black45,
                icon: Icons.close,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        )
      ],
    );
  }
}

Widget _button({
  required final String text,
  required final Color bgColor,
  required final Color textColor,
  required final IconData icon,
  required final Function() onTap,
}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 8.0,
      ),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 18,
          ),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 15
            ),
          ),
        ],
      ),
    ),
  );
}
