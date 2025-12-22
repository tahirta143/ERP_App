import 'package:flutter/material.dart';

class TaskProgress extends StatefulWidget {
  const TaskProgress({super.key});

  @override
  State<TaskProgress> createState() => _TaskProgressState();
}

class _TaskProgressState extends State<TaskProgress> {
  TextEditingController searchController = TextEditingController();
  String selectedFilter = "All";

  // Sample task data
  List<Map<String, dynamic>> taskList = [
    {
      "assigned": "ASSIGN001",
      "assignment": "Mobile App",
      "tasks": ["UI Design", "Frontend", "Backend"],
      "status": "In Progress"
    },
    {
      "assigned": "ASSIGN002",
      "assignment": "Website",
      "tasks": ["Wireframe", "UI Design"],
      "status": "Complete"
    },
    {
      "assigned": "ASSIGN003",
      "assignment": "ERP Module",
      "tasks": ["Database", "API Integration"],
      "status": "In Progress"
    },
  ];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = taskList;
  }

  void filterTasks(String query) {
    setState(() {
      filteredList = taskList.where((task) {
        final matchesSearch = task["assigned"]
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()) ||
            task["assignment"]
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
        final matchesFilter = selectedFilter == "All" ||
            task["status"] == selectedFilter;
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      filterTasks(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
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
            "Tasks Progress",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              onChanged: filterTasks,
              decoration: InputDecoration(
                hintText: "Search tasks...",
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

            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["All", "In Progress", "Complete"].map((filter) {
                bool isSelected = selectedFilter == filter;
                return ElevatedButton(
                  onPressed: () => setFilter(filter),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isSelected ? Colors.blue : Colors.grey.shade200,
                    foregroundColor:
                    isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(filter),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final task = filteredList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Assigned Staff
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                task["assigned"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Icon(
                                task["status"] == "Complete"
                                    ? Icons.check_circle
                                    : Icons.timelapse,
                                color: task["status"] == "Complete"
                                    ? Colors.green
                                    : Colors.orange,
                              )
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Assignment Name
                          Text(
                            task["assignment"],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),

                          // Task list
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (task["tasks"] as List<String>)
                                .map((t) => Row(
                              children: [
                                const Icon(Icons.circle,
                                    size: 6, color: Colors.black54),
                                const SizedBox(width: 6),
                                Text(t),
                              ],
                            ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
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
