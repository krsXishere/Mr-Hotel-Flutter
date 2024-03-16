import 'package:flutter/material.dart';
import '../common/constant.dart';

class CustomDropdownButtonWidget extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;

  const CustomDropdownButtonWidget({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
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
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
