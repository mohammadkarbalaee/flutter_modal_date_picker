import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modal_date_picker/flutter_modal_date_picker.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData(), home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String date = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      'show date picker',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () async {
                      String chosenDate =
                          await showModalDatePicker(context, DateTime.now());
                      setState(() {
                        date = chosenDate;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      backgroundColor: Colors.amber,
                      fontSize: 30
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
