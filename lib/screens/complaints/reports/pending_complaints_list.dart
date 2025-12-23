import 'package:flutter/material.dart';

class PendingComplaintsList extends StatefulWidget {
  const PendingComplaintsList({super.key});

  @override
  State<PendingComplaintsList> createState() => _PendingComplaintsListState();
}

class _PendingComplaintsListState extends State<PendingComplaintsList> {

  // ===== Selected Employee Filter =====
  String selectedEmployee = 'All';

  // ===== Complaint Data =====
  List<Map<String, dynamic>> complaintList = [
    {
      "id": "C1001",
      "employee": "Ahmed Ali",
      "products": ["Website", "Mobile App"],
      "date": "2025-12-22",
      "customer": "Ali",
      "status": "Pending",
    },
    {
      "id": "C1002",
      "employee": "Sara Khan",
      "products": ["Ecommerce Site"],
      "date": "2025-12-21",
      "customer": "Samia",
      "status": "Pending",
    },
    {
      "id": "C1003",
      "employee": "Usman Shah",
      "products": ["ERP Module"],
      "date": "2025-12-20",
      "customer": "Haider",
      "status": "Pending",
    },
  ];

  List<Map<String, dynamic>> get filteredList {
    if (selectedEmployee == 'All') return complaintList;
    return complaintList
        .where((e) => e["employee"] == selectedEmployee)
        .toList();
  }

  List<String> get employeeList {
    final employees =
    complaintList.map((e) => e["employee"].toString()).toSet().toList();
    return ['All', ...employees];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ================= APP BAR =================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
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
            "Pending Complaints",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ===== HEADER + COUNT =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pending Complaints",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Total: ${filteredList.length}",
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ===== EMPLOYEE DROPDOWN FILTER =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedEmployee,
                  isExpanded: true,
                  items: employeeList
                      .map(
                        (emp) => DropdownMenuItem(
                      value: emp,
                      child: Text(emp),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedEmployee = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== LIST =====
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final complaint = filteredList[index];
                  final products =
                  (complaint["products"] as List).cast<String>();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // DATE + STATUS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              complaint["date"],
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Pending",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // ID + CUSTOMER
                        Text(
                            "${complaint["id"]} - ${complaint["employee"]}",

                            style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 6),

                        // ASSIGNED STAFF
                        Text(
                          "customer: ${complaint["customer"]}",
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey[700]),
                        ),

                        const SizedBox(height: 8),

                        // PRODUCTS
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: products
                              .map(
                                (p) => Chip(
                              label: Text(p, style: const TextStyle(fontSize: 12)),
                              backgroundColor: Colors.grey.shade200,
                            ),
                          )
                              .toList(),
                        ),
                      ],
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
