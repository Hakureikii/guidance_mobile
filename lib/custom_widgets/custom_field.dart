import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? icon;
  final bool? enabled;
  final bool readOnly;
  final TextEditingController? textController;
  final VoidCallback? onTap;
  final FormFieldValidator? validator;

  const CustomField({
    super.key,
    required this.label,
    this.hint,
    this.icon,
    this.enabled,
    required this.readOnly,
    this.textController,
    this.onTap,
    this.validator,
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      controller: textController,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        icon: icon != null ? Icon(icon) : null,
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      ),
    );
  }
}
