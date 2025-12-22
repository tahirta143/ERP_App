import 'package:erp/widgets/app_textfields.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_buttons.dart';
import '../../../widgets/start_end_date_picker.dart';

class AddComplaints extends StatefulWidget {
  const AddComplaints({super.key});

  @override
  State<AddComplaints> createState() => _AddComplaintsState();
}

class _AddComplaintsState extends State<AddComplaints> {
  // Controllers
  TextEditingController complaintController = TextEditingController();
  TextEditingController endDateController =TextEditingController();
  // Dummy customer list
  final List<String> customers = ["Ali Khan", "Sara Malik", "Usman Shah"];
  String? selectedCustomer;

  // Dummy products for each customer
  final Map<String, List<String>> customerProducts = {
    "Ali Khan": ["Website", "Mobile App", "ERP Module","ERP Module","ERP Module"],
    "Sara Malik": ["Ecommerce Site", "Landing Page",'graphic desghn'],
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
            "Add Complaint",
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
          FloatingDateField(
          label: "Complaint Date ",
          icon: Icons.date_range,
          controller: endDateController, title: 'Complaint date',
        ),FloatingInputField(

              hintText: "Enter Task name ",
              icon: Icons.confirmation_number,
              title: 'Complaint Id',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Customer",style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.grey[800],fontSize: 16,),),
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
                labelText: "Select Customer",
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 22),

                    // Limit visible products to 3 with scroll
                    SizedBox(
                      height: selectedProducts.length > 3 ? 120 : selectedProducts.length * 50.0,
                      child: Scrollbar(
                        thumbVisibility: true, // always show scrollbar
                        trackVisibility: true, // optional: show track
                        thickness: 8, // width of scrollbar
                        radius: const Radius.circular(8),
                        scrollbarOrientation: ScrollbarOrientation.right, // put on left side
                        child: SingleChildScrollView(
                          child: Column(
                            children: selectedProducts.keys
                                .map(
                                  (product) => CheckboxListTile(
                                title: Text(product),
                                value: selectedProducts[product],
                                onChanged: (value) {
                                  setState(() {
                                    selectedProducts[product] = value ?? false;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // Complaint description
            TextField(
              controller: complaintController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Complaint Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            Center(
              child: CustomElevatedButton(
                onPressed: () {
                  final selectedProductsList = selectedProducts.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .toList();

                  // Debug print
                  print("Customer: $selectedCustomer");
                  print("Products: $selectedProductsList");
                  print("Complaint: ${complaintController.text}");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Complaint Added Successfully"),
                    ),
                  );
                },
                text: 'Add Complaint',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
