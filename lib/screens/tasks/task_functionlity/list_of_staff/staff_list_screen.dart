import 'package:erp/provider/Task/staff_provider.dart';
import 'package:erp/screens/tasks/task_functionlity/list_of_staff/add_new_staff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Model/Task_model/staff_list_model.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  TextEditingController searchController = TextEditingController();

  // Dummy staff data
  // List<Map<String, String>> staffList = [
  //   {"name": "Ali Khan", "phone": "0301-1234567"},
  //   {"name": "Ahmed Raza", "phone": "0302-9876543"},
  //   {"name": "Sara Malik", "phone": "0303-4567890"},
  //   {"name": "Usman Shah", "phone": "0304-1122334"},
  // ];

  List<Map<String, String>> filteredList = [];

  @override
  // void initState() {
  //   super.initState();
  //   filteredList = staffList;
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      context.read<StaffProvider>().getStaffList();
    });
  }

  void filterStaff(
      String query,
      List<StaffListModel> staff,
      ) {
    setState(() {
      // filteredList = staff
      //     .where((task) =>
      // task.task.toLowerCase().contains(query.toLowerCase()) ||
      //     task.staff.toLowerCase().contains(query.toLowerCase()))
      //     .toList();
    });
  }

  // void filterStaff(String query) {
  //   setState(() {
  //     filteredList = staffList
  //         .where(
  //           (staff) =>
  //               staff["name"]!.toLowerCase().contains(query.toLowerCase()) ||
  //               staff["phone"]!.contains(query),
  //         )
  //         .toList();
  //   });
  // }

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
            "Staff Management",
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
                  "Staff",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to Add Staff Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNewStaff()),
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
             // onChanged: filterStaff,
              decoration: InputDecoration(
                hintText: "Search staff...",
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

              child:  Consumer<StaffProvider>(
                builder: (context, provider,child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.staffList.isEmpty) {
                    return const Center(child: Text("No Task Found"));
                  }
                  return ListView.builder(
                    itemCount: provider.staffList.length,
                      itemBuilder: (context, index) {
                        final staff = provider.staffList[index];
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

                              // ===== NAME =====
                              title: Text(
                                staff.staffName!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // ===== PHONE =====
                              subtitle: Text(
                                staff.staffPhone!,
                                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                              ),

                              // ===== ACTION BUTTONS =====
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 28,
                                    height: 20,
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
                                        // Edit staff
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  const SizedBox(width: 0),
                                  Container(
                                    width: 28,
                                    height: 20,
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
                                        // Delete staff
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              // OPTIONAL: Tap whole tile
                              onTap: () {
                                // View staff details
                              },
                            ),
                          );

                      }
                        );
                }
              ),

              // child: ListView.builder(
              //   itemCount: filteredList.length,
              //   itemBuilder: (context, index) {
              //     final staff = filteredList[index];

                  //

              ),
          ],
        ),
      ),
    );
  }
}
