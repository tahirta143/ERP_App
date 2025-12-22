
import 'package:erp/screens/tasks/reports/task_progress.dart';
import 'package:erp/screens/tasks/task_functionlity/Staff_assign_task/assign_staff_task.dart';
import 'package:erp/screens/tasks/task_functionlity/list_of_staff/staff_list_screen.dart';
import 'package:erp/screens/tasks/task_functionlity/list_of_tasks/task_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/erpcards.dart';
import '../../widgets/summarycards.dart';

class Tasksdashboard extends StatefulWidget {
  const Tasksdashboard({super.key});
  @override
  State<Tasksdashboard> createState() => _TasksdashboardState();
}

class _TasksdashboardState extends State<Tasksdashboard> {


  int selectedTab = 0;
  final List<String> tabs = ["Functionalities", "Reports", "Setups"];
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
            "Tasks Management",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child:Padding(
              padding: const EdgeInsets.all(14),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SummaryCard(
                    title: "Tasks Completed",
                    value: "12",
                    icon: Icons.check_circle, // completion icon
                    index: 1,
                    onTap: () {

                    },
                  ),

                  SummaryCard(
                    title: "Tasks In Progress",
                    value: "5",
                    icon: Icons.autorenew, // in-progress icon
                    index: 2,
                    onTap: () {
                      // Navigate to In Progress Tasks Screen
                    },
                  ),
                  SummaryCard(
                    title: "Delayed Tasks",
                    value: "4",
                    icon: Icons.schedule, // task delay icon
                    index: 4,
                    onTap: () {
                      // Navigate to Delayed Tasks Screen
                    },
                  )
                  ,
                  SummaryCard(
                    title: "Add tasks",
                    value: "15",
                    icon: Icons.shopping_cart,
                    index: 8,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskListScreen()));

                    },
                  ),
                ],
              ),
            ),

          ),
          const SizedBox(height: 60),
          // ===================== ROUNDED TABS =====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: List.generate(
                tabs.length,
                (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedTab == index
                            ? const Color(0xFF1976D2)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          if (selectedTab == index)
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Text(
                        tabs[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedTab == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ===================== TAB CONTENT =====================
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  // ===================== TAB CONTENT SWITCH =====================
  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _functionalitiesTab();
      case 1:
        return _reportsTab();
      case 2:
        return _setupTab();
      default:
        return const SizedBox();
    }
  }

  // ===================== FUNCTIONALITIES =====================
  Widget _functionalitiesTab() {
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = (screenWidth ~/ 120).clamp(2, 4);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: columns, // same style as dashboard
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
        children: [
          ErpCard(
            title: "Staff Assigned Task",
            icon: Icons.assignment_ind, // assigned to staff
            color: Colors.green,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskAssigneScreen()));
            },
          ),
        ],
      ),
    );
  }

  // ===================== REPORTS =====================
  Widget _reportsTab() {
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = (screenWidth ~/ 120).clamp(2, 4);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: columns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
        children: [
          ErpCard(
            title: "Tasks Progress",
            icon: Icons.timeline, // shows progress/timeline
            color: Colors.blue,
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskProgress()));},
          ),
          ErpCard(
            title: "Task Completed",
            icon: Icons.assignment_ind, // assigned to staff
            color: Colors.green,
            onTap: () {},
          ),
          ErpCard(
            title: "Delayed Tasks",
            icon: Icons.schedule, // shows delay or time
            color: Colors.deepOrange,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ===== SETUPS =======
  Widget _setupTab() {
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = (screenWidth ~/ 120).clamp(2, 4);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: columns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
        children: [
          ErpCard(
            title: "List of Tasks",
            icon: Icons.task_rounded,
            color: Colors.green,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskListScreen()));
            },
          ),
          ErpCard(
            title: "List of Staff",
            icon: Icons.people,
            color: Colors.orange,
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>StaffListScreen()));},
          ),
        ],
      ),
    );
  }
}
