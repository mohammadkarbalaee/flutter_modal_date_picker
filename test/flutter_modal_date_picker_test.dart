import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../lib/flutter_modal_date_picker.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData(), home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      CustomDatePickerDialog(context, DateTime.now());
    });

    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
