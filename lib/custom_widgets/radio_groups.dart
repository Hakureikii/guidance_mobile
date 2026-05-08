import 'package:flutter/material.dart';

class RadioGroups extends StatelessWidget {
  final String? radioTitle;
  final IconData? icon;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const RadioGroups({
    super.key,
    required this.radioTitle,
    required this.options,
    required this.onChanged,
    this.selectedValue,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          title: Text(
            option,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: option,
          groupValue: selectedValue,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }
}