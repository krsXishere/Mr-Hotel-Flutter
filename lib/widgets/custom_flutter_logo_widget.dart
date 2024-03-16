import 'package:flutter/material.dart';

class CustomFlutterLogoWidget extends StatelessWidget {
  const CustomFlutterLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorFiltered(
      colorFilter: ColorFilter.srgbToLinearGamma(
        
      ),
      child: FlutterLogo(size: 100),
    );
  }
}
