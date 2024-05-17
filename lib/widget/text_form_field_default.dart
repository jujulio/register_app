import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldDefault extends StatelessWidget {
  final String labelText;
  final int? maxLength;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const TextFormFieldDefault({
    super.key,
    this.labelText = '',
    this.maxLength,
    this.keyboardType,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatters,
      validator: validator,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 15.0,
          color: Colors.black,
        ),
        helperStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.blue),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
