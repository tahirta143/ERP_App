import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {

  final String hint;
  final IconData icon;
  final List<String> items;
  final String? value;
  final title;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,

    required this.hint,
    required this.icon,
    required this.items,
    required this.value,
    required this.onChanged, this.title,
  });




  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.035, // responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
              .toList(),
          onChanged: onChanged,

          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
