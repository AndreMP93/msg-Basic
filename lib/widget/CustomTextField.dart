import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool autofocus;
  final bool obscureText;

  const CustomTextField({
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.validator,
    this.autofocus = false,
    this.obscureText = false,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(fontSize: 20),
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
  }
}
