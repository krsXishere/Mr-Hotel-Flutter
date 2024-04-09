import 'package:flutter/material.dart';
import '../common/constant.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final String label;
  final bool isPasswordField;
  final TextEditingController controller;
  final bool isObsecure;
  final Function() onTap;
  final TextInputType type;
  final bool isNumber, showLabel, isBayar, isFilled;

  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.label,
    required this.isPasswordField,
    required this.controller,
    required this.type,
    this.isObsecure = false,
    required this.onTap,
    this.isNumber = false,
    this.showLabel = true,
    this.isBayar = true,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return isPasswordField == false && isBayar == false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showLabel
                  ? Text(
                      label,
                      style: secondaryTextStyle,
                    )
                  : const SizedBox.shrink(),
              TextFormField(
                style: secondaryTextStyle,
                cursorColor: primaryColor,
                controller: controller,
                keyboardType: type,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  fillColor: white,
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: primaryTextStyle.copyWith(
                    fontWeight: regular,
                    color: grey400,
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: grey500,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            ],
          )
        : isBayar == true && isPasswordField == false
            ? Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    primaryShadow,
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    style: secondaryTextStyle,
                    cursorColor: primaryColor,
                    controller: controller,
                    keyboardType: type,
                    decoration: InputDecoration(
                      prefixIcon: isBayar
                          ? SizedBox(
                              width: 10,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Rp",
                                      style: secondaryTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      filled: isFilled,
                      fillColor: white,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: primaryTextStyle.copyWith(
                        fontWeight: regular,
                        color: grey400,
                        fontSize: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: secondaryTextStyle,
                  ),
                  TextFormField(
                    style: secondaryTextStyle,
                    cursorColor: primaryColor,
                    controller: controller,
                    keyboardType: type,
                    obscureText: isObsecure,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: onTap,
                        child: Icon(
                          isObsecure ? Icons.visibility_off : Icons.visibility,
                          color: isObsecure ? grey500 : primaryColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      filled: false,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: primaryTextStyle.copyWith(
                        fontWeight: regular,
                        color: grey400,
                        fontSize: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: grey500,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }
}
