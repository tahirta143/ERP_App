import 'dart:convert';

import 'package:erp/Model/Task_model/staff_list_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class StaffProvider with ChangeNotifier{
   bool _isLoading = false;
   List<StaffListModel> _staffList=[];

   //getx

   bool get isLoading=> _isLoading;
   List<StaffListModel> get staffList => _staffList;

   // function for call staff mock data  display screen

  Future<void> getStaffList () async{
    _isLoading= true;
    notifyListeners();
    final String response=await rootBundle.loadString('assets/json/Staff_list.json');
    final List data = json.decode(response);
    _staffList= data.map((e)=>StaffListModel.fromJson(e)).toList();
    _isLoading=false;
    notifyListeners();

  }

}