import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_textfields.dart';
import '../../../../widgets/start_end_date_picker.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
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
             const FloatingInputField(
                label: "Task Details",
                hintText: "Enter Task Details",

                title: 'Task Details',
                maxLines: 3,
              ), const SizedBox(height: 12),
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
              ),const FloatingInputField(
                label: "Resources",
                hintText: "Enter Task name ",
                icon: Icons.task_outlined,
                title: 'No.of Resources(required)',
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
