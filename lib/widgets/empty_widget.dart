import 'package:flutter/material.dart';
import '../common/constant.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final bool defaultColor;
  const EmptyWidget({
    super.key,
    required this.title,
    this.defaultColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height(context) * 0.2),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.archive_rounded,
              color: defaultColor ? Colors.deepPurple : white,
              size: height(context) * 0.1,
            ),
            Text(
              title,
              style: defaultColor ? secondaryTextStyle : primaryTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
