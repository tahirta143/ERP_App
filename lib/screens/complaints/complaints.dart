import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/erpcards.dart';
import '../../widgets/summarycards.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  int selectedTab = 0;
  final List<String> tabs = ["Functionalities", "Reports", "Setups"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ===================== APP BAR =====================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
            "Complaints",
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
                  title: "Total Complaints",
                  value: "12",
                  icon: Icons.report_problem,
                  index: 4,
                  onTap: () {},
                ),
                SummaryCard(
                  title: "Pending Complaints",
                  value: "5",
                  icon: Icons.pending_actions,
                  index: 2,
                  onTap: () {},
                ),
                SummaryCard(
                  title: "Solved Complaints",
                  value: "4",
                  icon: Icons.check_circle,
                  index: 1,
                  onTap: () {},
                ),
                SummaryCard(
                  title: "Add Complaints",
                  value: "15",
                  icon: Icons.add_circle,
                  index: 8,
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

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
        crossAxisCount: columns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
        children: [
          ErpCard(
            title: "Launch New Complaint",
            icon: Icons.report_problem,
            color: Colors.blue,
            onTap: () {},
          ),
          ErpCard(
            title: "Assigned Complaint to Staff",
            icon: Icons.assignment_ind,
            color: Colors.green,
            onTap: () {},
          ),
          ErpCard(
            title: "Complaint Resolved",
            icon: Icons.check_circle,
            color: Colors.orange,
            onTap: () {},
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
            title: "Pending Complaints",
            icon: Icons.pending_actions,
            color: Colors.blue,
            onTap: () {},
          ),
          ErpCard(
            title: "Complaints Against Customer",
            icon: Icons.person_2,
            color: Colors.green,
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
            title: "Maintenance Contract Types",
            icon: Icons.store,
            color: Colors.blue,
            onTap: () {},
          ),
          ErpCard(
            title: "Create Complaints",
            icon: Icons.report_problem,
            color: Colors.green,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
