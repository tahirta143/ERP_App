import 'package:erp/screens/complaints/functionality/complaint_attended/Add_complaint_attended.dart';
import 'package:flutter/material.dart';

class ComplaintAttendedList extends StatefulWidget {
  const ComplaintAttendedList({super.key});

  @override
  State<ComplaintAttendedList> createState() => _ComplaintAttendedListState();
}

class _ComplaintAttendedListState extends State<ComplaintAttendedList> {
  TextEditingController searchController = TextEditingController();

  // Updated complaint data
  List<Map<String, dynamic>> complaintList = [
    {
      "id": "C1001",
      "customer": "Ahmed Ali",
      "products": ["Website", "Mobile App", "ERP Module"],
      "date": "2025-12-22",
      "assign": "Staff001"
    },
    {
      "id": "C1002",
      "customer": "Sara Khan",
      "products": ["Ecommerce Site", "Mobile App"],
      "date": "2025-12-21",
      "assign": "Staff002"
    },
    {
      "id": "C1003",
      "customer": "Usman Shah",
      "products": ["Mobile App", "Odoo ERP", "CRM Module"],
      "date": "2025-12-20",
      "assign": "Staff003"
    },
    {
      "id": "C1004",
      "customer": "Ali Raza",
      "products": ["ERP Module"],
      "date": "2025-12-19",
      "assign": "Staff004"
    }, {
      "id": "C1004",
      "customer": "Ali Raza",
      "products": ["ERP Module"],
      "date": "2025-12-19",
      "assign": "Staff004"
    }, {
      "id": "C1004",
      "customer": "Ali Raza",
      "products": ["ERP Module"],
      "date": "2025-12-19",
      "assign": "Staff004"
    },
  ];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = complaintList;
  }

  void filterComplaints(String query) {
    setState(() {
      filteredList = complaintList
          .where((complaint) =>
      complaint["id"].toString().toLowerCase().contains(query.toLowerCase()) ||
          complaint["customer"].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
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
            "Complaint Attended List",
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
            // Header + Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  " Complaint Attended",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddComplaintAttended()),
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

            // Search bar
            TextField(
              controller: searchController,
              onChanged: filterComplaints,
              decoration: InputDecoration(
                hintText: "Search by ID or Customer...",
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

            // Complaints List
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final complaint = filteredList[index];
                  final products = (complaint["products"] as List<dynamic>?)
                      ?.map((e) => e.toString())
                      .toList() ??
                      [];

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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date + Assigned Staff
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                complaint["date"] ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                complaint["assign"] ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // ID + Customer Name + Edit/Delete buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${complaint["id"]} - ${complaint["customer"]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
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
                                      onPressed: () {},
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
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Products
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: products
                                .map(
                                  (product) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  product,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            )
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
