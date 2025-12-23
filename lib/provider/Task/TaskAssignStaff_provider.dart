import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../Model/Task_model/Assign_task_staff_model.dart';

class TaskassignstaffProvider with ChangeNotifier {
  List<AssignTaskStaffModel> _assignTask = [];
  bool _isLoading = false;

  List<AssignTaskStaffModel> get assignTask => _assignTask;
  bool get isLoading => _isLoading;

  Future<void> getAssignStaff() async {
    _isLoading = true;
    notifyListeners();

    final String response = await rootBundle.loadString('assets/json/Assigned_task_staff.json');

    final List data = json.decode(response);
    print(data);

    _assignTask = data.map((e) => AssignTaskStaffModel.fromJson(e)).toList();

    _isLoading = false;
    notifyListeners();
  }
  void addTask(AssignTaskStaffModel task) {
    _assignTask.add(task);
    notifyListeners();
  }
}
