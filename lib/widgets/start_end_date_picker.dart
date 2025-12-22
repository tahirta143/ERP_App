import 'package:flutter/material.dart';

class FloatingDateField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String title;

  const FloatingDateField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.title,
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
        TextFormField(
          controller: controller,
          readOnly: true, // important! opens date picker on tap
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              controller.text = formattedDate;
            }
          },
        ),
      ],
    );
  }
}
