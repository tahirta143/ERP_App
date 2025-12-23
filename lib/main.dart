import 'package:erp/home.dart';
import 'package:erp/provider/Task/TaskAssignStaff_provider.dart';
import 'package:erp/provider/Task/staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>TaskassignstaffProvider()),
    ChangeNotifierProvider(create: (_)=>StaffProvider()),

  ],
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),

      ),
      home:Home(),
    );
  }
}