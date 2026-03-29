import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final bool isObscured;
  final String label;
  final String? hint;
  final IconData? icon;
  final bool? enabled;
  final bool readOnly;
  final TextEditingController? textController;
  final VoidCallback? onTap;
  final Function(String)? fieldOnChanged;
  final FormFieldValidator<String>? validator;

  const CustomField({
    super.key,
    required this.isObscured,
    required this.label,
    this.hint,
    this.icon,
    this.enabled,
    required this.readOnly,
    this.textController,
    this.onTap,
    this.validator,
    this.fieldOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: fieldOnChanged,
      obscureText: isObscured,
      validator: validator,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      controller: textController,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF048c6c), width: 2),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: Color(0xFF048c6c),
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

class PasswordField extends StatelessWidget {
  final TextEditingController? textController;
  final VoidCallback passwordToggle;
  final String? label;
  final String? hint;
  final bool isObscured;
  final IconData? icon;
  final FormFieldValidator<String> validator;

  const PasswordField({
    super.key,
    this.textController,
    this.icon,
    this.label,
    this.hint,

    required this.passwordToggle,
    required this.validator,
    required this.isObscured,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscured,
      validator: validator,
      controller: textController,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF048c6c), width: 2),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: Color(0xFF048c6c),
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        icon: icon != null ? Icon(icon) : null,
        labelText: label,
        suffixIcon: IconButton(
          onPressed: passwordToggle,
          icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
        ),
        hintText: hint,
        hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      ),
    );
  }
}

class TextArea extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final String? label;
  final String? hint;
  final IconData? icon;
  final TextEditingController textController;

  const TextArea({
    super.key, 
    this.hint,
    this.label,
    this.icon,
    
    required this.textController,
    required this.validator
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      validator: validator,
      controller: textController,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF048c6c), width: 2),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: Color(0xFF048c6c),
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
