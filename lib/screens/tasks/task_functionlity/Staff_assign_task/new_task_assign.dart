import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_textfields.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/start_end_date_picker.dart';

class AddNewTaskStaff extends StatefulWidget {
  const AddNewTaskStaff({super.key});

  @override
  State<AddNewTaskStaff> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTaskStaff> {
  List<String> taskTypes = [
    "Tech Solutions Inc.",
    "Green Energy Corp.",
    "Urban Logistic Ltd.",
  ];
  // Departments
  List<String> departments = [
    "IT",
    "HR",
    "Finance",
    "Sales",
  ];

// Employees mapped to department
  List<String> staff = [
    "Shehbaz",
    "Ali",
    "Tahir",
    "Iman",
  ];

  String? selectedDepartment;
  String? selectedEmployee;

  String? selectedTaskType;

  TextEditingController taskNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Add New Task",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const FloatingInputField(
                label: "Task",
                hintText: "Enter Task name ",
                icon: Icons.task_outlined,
                title: 'Task Name',
              ),
              CustomDropdownField(
                title: "Task Assigned",
                hint: "Select a Customer",
                icon: Icons.work_outline,
                items: taskTypes,            // 👈 LIST DATA
                value: selectedTaskType,     // 👈 SELECTED VALUE
                onChanged: (value) {
                  setState(() {
                    selectedTaskType = value;
                  });
                },
              ),

              const SizedBox(height: 12),
              FloatingDateField(
                label: "Start Date",
                icon: Icons.date_range,
                controller: startDateController, title: 'Start Date',
              ),

              const SizedBox(height: 12),
              FloatingDateField(
                label: "End Date",
                icon: Icons.date_range,
                controller: endDateController, title: 'End Date',
              ), CustomDropdownField(
                title: "Department",
                hint: "Select Department",
                icon: Icons.work_outline,
                items: departments,            // 👈 LIST DATA
                value: selectedDepartment,     // 👈 SELECTED VALUE
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value;
                  });
                },
              ), CustomDropdownField(
                title: "Staff",
                hint: "Select Staff",
                icon: Icons.work_outline,
                items: staff,            // 👈 LIST DATA
                value: selectedEmployee,     // 👈 SELECTED VALUE
                onChanged: (value) {
                  setState(() {
                    selectedEmployee = value;
                  });
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: CustomElevatedButton(
                  text: "Add New Task",
                  icon: Icons.add,
                  color: Color(0xFF42A5F5),
                  onPressed: () {
                    print("Add Staff button clicked");
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
