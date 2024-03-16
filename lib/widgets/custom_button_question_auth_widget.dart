import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../common/constant.dart';

class CustomButtonQuestionAuthWidget extends StatelessWidget {
  final String question, buttonText;
  final Widget page;

  const CustomButtonQuestionAuthWidget({
    super.key,
    required this.question,
    required this.buttonText,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: primaryTextStyle.copyWith(
            color: black,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: page,
                type: PageTransitionType.rightToLeft,
              ),
              (Route<dynamic> route) => false,
            );
          },
          child: Text(
            buttonText,
            style: primaryTextStyle.copyWith(
              color: secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
