import 'package:flutter/material.dart';

class RadioGroups extends StatefulWidget {
  final String? radioTitle;
  final IconData? icon;
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String? civilStatus;

  const RadioGroups({
    super.key,
    required this.radioTitle,
    required this.options,
    required this.onChanged,
    this.selectedValue,
    this.icon,
    this.civilStatus,

  });

  @override
  State<RadioGroups> createState() => _RadioGroupsState();
}

class _RadioGroupsState extends State<RadioGroups> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// Title Row
        // Row(
        //   children: [
        //     if (widget.icon != null)

        //     if (widget.icon != null) const SizedBox(width: 8),

        //     Padding(
        //       padding: const EdgeInsets.only(top: 20),
        //       child: Text(
        //         widget.radioTitle ?? '',
        //         style: const TextStyle(
        //           fontFamily: 'Montserrat',
        //           fontSize: 14.5,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        /// Radio Options
        Column(
          children: widget.options.map((option) {
            return RadioListTile<String>(
              title: Text(
                option,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )
              ),
              value: option,
              groupValue: widget.selectedValue,
              onChanged: widget.onChanged,
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
            );
          }).toList(),
        ),
      ],
    );
  }
}