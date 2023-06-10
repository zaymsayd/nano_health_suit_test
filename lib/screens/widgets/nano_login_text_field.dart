import 'package:flutter/material.dart';

class NanoLoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Widget? suffixIcon;
  final bool obscureText;
  const NanoLoginTextField({
    Key? key,
    required this.controller,
    this.label,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
