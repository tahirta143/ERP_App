import 'package:erp/screens/tasks/task_functionlity/list_of_staff/add_new_staff.dart';
import 'package:erp/screens/tasks/task_functionlity/list_of_tasks/add_new_task.dart';
import 'package:flutter/material.dart';

import 'new_task_assign.dart';

class TaskAssigneScreen extends StatefulWidget {
  const TaskAssigneScreen({super.key});

  @override
  State<TaskAssigneScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskAssigneScreen> {
  TextEditingController searchController = TextEditingController();

  // Dummy staff data
  List<Map<String, String>> taskList = [
    {"Assign_Id":"Assign001","task": "website", "disk": "shahbaz"},
    {"Assign_Id":"Assign002","task": "mobile app", "disk": "Tahir"},
    {"Assign_Id":"Assign003","task": "ecommerce website", "disk": "Ali"},
    {"Assign_Id":"Assign004","task": "mobile app", "disk": "Zain"},
  ];

  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = taskList;
  }

  void filterStaff(String query) {
    setState(() {
      filteredList = taskList
          .where(
            (staff) =>
        staff["task"]!.toLowerCase().contains(query.toLowerCase()) ||
            staff["disc"]!.contains(query),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ===================== APP BAR =====================
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
            "Assigned Task To Staff",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),

      // ===================== BODY =====================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== STAFF HEADER + ADD BUTTON =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Assign Task",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to Add Staff Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>AddNewTaskStaff()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF1976D2),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ===== SEARCH BAR =====
            TextField(
              controller: searchController,
              onChanged: filterStaff,
              decoration: InputDecoration(
                hintText: "Search task...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== STAFF LIST =====
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final task = filteredList[index]; // each task is different

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      // ===== TASK NAME =====
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task["Assign_Id"] ?? "No Task",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            task["task"] ?? "No Task",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // ===== TASK DISK =====
                      subtitle: Text(
                        task["disk"] ?? "No disk",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),

                      // ===== ACTION BUTTONS =====
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue.shade100,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 18,
                              ),
                              onPressed: () {
                                // Edit task
                              },
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red.shade100,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 18,
                              ),
                              onPressed: () {
                                // Delete task
                              },
                            ),
                          ),
                        ],
                      ),

                      onTap: () {
                        // View task details
                      },
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
