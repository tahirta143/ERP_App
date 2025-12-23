import 'package:erp/screens/tasks/task_functionlity/list_of_staff/add_new_staff.dart';
import 'package:erp/screens/tasks/task_functionlity/list_of_tasks/add_new_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Model/Task_model/Assign_task_staff_model.dart';
import '../../../../provider/Task/TaskAssignStaff_provider.dart';
import 'new_task_assign.dart';

class TaskAssigneScreen extends StatefulWidget {
  const TaskAssigneScreen({super.key});

  @override
  State<TaskAssigneScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskAssigneScreen> {
  TextEditingController searchController = TextEditingController();

  List<AssignTaskStaffModel> filteredList = [];
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TaskassignstaffProvider>().getAssignStaff();
    });
  }


  void filterStaff(
      String query,
      List<AssignTaskStaffModel> tasks,
      ) {
    setState(() {
      filteredList = tasks
          .where((task) =>
      task.task.toLowerCase().contains(query.toLowerCase()) ||
          task.staff.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    final task=Provider.of<TaskassignstaffProvider>(context);
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
              onChanged: (value) {
                filterStaff(
                  value,
                  context.read<TaskassignstaffProvider>().assignTask,
                );
              },
              decoration: InputDecoration(
                hintText: "Search task...",
                prefixIcon: const Icon(Icons.search),
              ),
            ),


            const SizedBox(height: 16),

            // ===== STAFF LIST =====
            Expanded(
              child: Consumer<TaskassignstaffProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final tasks = searchController.text.isEmpty
                      ? provider.assignTask
                      : filteredList;

                  if (tasks.isEmpty) {
                    return const Center(child: Text("No Task Found"));
                  }

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

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
                          title: Text(
                            task.assignid,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task.task),
                              Text(
                                task.staff,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18,color: Colors.blue,),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18,color: Colors.blue,),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
