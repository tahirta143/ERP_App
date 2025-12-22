import 'package:erp/widgets/app_textfields.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/start_end_date_picker.dart';

class AddComplaintAttended extends StatefulWidget {
  const AddComplaintAttended({super.key});

  @override
  State<AddComplaintAttended> createState() => _AddComplaintAttendedState();
}

class _AddComplaintAttendedState extends State<AddComplaintAttended> {
  // Controllers
  TextEditingController complaintController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  // Dummy customer list
  final List<String> customers = ["Ali Khan", "Sara Malik", "Usman Shah"];
  String? selectedCustomer;
  final ScrollController _productScrollController = ScrollController();

  // Dummy products for each customer
  final Map<String, List<String>> customerProducts = {
    "Ali Khan": [
      "Website",
      "Mobile App",
      "ERP Module",
      "ERP Module",
      "ERP Module",
    ],
    "Sara Malik": ["Ecommerce Site", "Landing Page", 'graphic desghn'],
    "Usman Shah": ["Mobile App", "ERP Module", "Dashboard"],
  };

  // Track selected products
  Map<String, bool> selectedProducts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
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
            "Add Attended Complaints",
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingInputField(
              hintText: "Attended Id",
              icon: Icons.confirmation_number,
              title: 'Attended Id',
            ),
            FloatingDateField(
              label: "Attended Date ",
              icon: Icons.date_range,
              controller: endDateController,
              title: 'Attended Date',
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Complaints",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 16,
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedCustomer,
              items: customers
                  .map(
                    (customer) => DropdownMenuItem(
                  value: customer,
                  child: Text(customer),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCustomer = value;

                  // Reset products selection
                  selectedProducts = {};
                  if (value != null && customerProducts[value] != null) {
                    for (var product in customerProducts[value]!) {
                      selectedProducts[product] = false;
                    }
                  }
                });
              },
              decoration: InputDecoration(
                labelText: "Select Complaints",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 19),

            // Show products if a customer is selected
            // Show products if a customer is selected
            if (selectedCustomer != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Products",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Stack(
                      children: [
                        SizedBox(
                          height: selectedProducts.length > 2
                              ? 110
                              : selectedProducts.length * 40.0,
                          child: Scrollbar(
                            controller: _productScrollController, // ✅ REQUIRED
                            thumbVisibility: true,
                            trackVisibility: true,
                            thickness: 6,
                            radius: const Radius.circular(8),
                            scrollbarOrientation: ScrollbarOrientation.right,
                            child: SingleChildScrollView(
                              controller:
                              _productScrollController, // ✅ REQUIRED
                              child: Column(
                                children: selectedProducts.keys
                                    .map(
                                      (product) => CheckboxListTile(
                                    dense: true,
                                    title: Text(
                                      product,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    value: selectedProducts[product],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedProducts[product] =
                                            value ?? false;
                                      });
                                    },
                                    controlAffinity:
                                    ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                      vertical: -2,
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),

                        // COUNT BADGE
                        Positioned(
                          top: -0,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${selectedProducts.values.where((v) => v).length}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 10,),
            FloatingInputField(
              hintText: "Complaint description",
              icon: Icons.description,
              title: 'Complaint description',
              maxLines: 4,
            ),
            FloatingInputField(
              hintText: "Remarks",
              icon: Icons.note,
              title: 'Remarks',

            ),
            const SizedBox(height: 16),
            // Submit button
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      // Add complaint logic
                    },
                    text: 'Resolved Complaint',
                    color: Colors.green, // left button green
                  ),
                ),
                const SizedBox(width: 12), // spacing
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      // Submit complaint logic
                    },
                    text: 'Refer For billing',
                    color: Colors.blue, // right button blue
                  ),
                ),
              ],
            )



          ],
        ),
      ),
    );
  }
}
