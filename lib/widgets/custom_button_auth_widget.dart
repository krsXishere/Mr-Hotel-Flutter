import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/constant.dart';

class CustomButtonAuthWidget extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function() onPressed;
  final Color color;
  final bool isGoogle, isEnable;

  const CustomButtonAuthWidget({
    super.key,
    required this.text,
    required this.color,
    required this.isLoading,
    this.isGoogle = false,
    this.isEnable = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isGoogle == false
        ? SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                backgroundColor: isEnable == true ? color : grey400,
              ),
              onPressed: isEnable == true ? onPressed : () {},
              child: isLoading == true
                  ? CupertinoActivityIndicator(
                      color: white,
                    )
                  : Text(
                      text,
                      style: primaryTextStyle,
                    ),
            ),
          )
        : SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                backgroundColor: color,
              ),
              onPressed: onPressed,
              child: isLoading == true
                  ? CupertinoActivityIndicator(
                      color: white,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://lh3.googleusercontent.com/COxitqgJr1sJnIDe8-jiKhxDx1FrYbtRHKJ9z_hELisAlapwE9LUPh6fcXIfb5vwpbMl4xl9H9TRFPc5NOO8Sb3VSgIBrfRYvW6cUA",
                          height: 18,
                          width: 18,
                        ),
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Text(
                          text,
                          style: primaryTextStyle,
                        ),
                      ],
                    ),
            ),
          );
  }
}
