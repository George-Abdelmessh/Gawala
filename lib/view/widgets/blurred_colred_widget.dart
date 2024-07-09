import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_size.dart';

class BlurredColoredWidget extends StatelessWidget {
  const BlurredColoredWidget({super.key, this.withLogo = true});

  final bool withLogo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.heightScale(context, 110),
      width: double.infinity,
      child: Stack(
        children: [
          _coloredContainer(Colors.red.withOpacity(0.5)),
          Positioned(
            left: 100,
            top: 20,
            child: _coloredContainer(Colors.green.withOpacity(0.5)),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: _coloredContainer(Colors.purpleAccent.withOpacity(0.5)),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 40,
              sigmaY: 40,
            ),
            child: Container(),
          ),
          if (withLogo)
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(AppImages.carrotLogo),
            ),
        ],
      ),
    );
  }
}

Widget _coloredContainer(Color color) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(50),
    ),
  );
}
