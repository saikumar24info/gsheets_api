// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gsheets_example/home_page.dart';
import 'package:gsheets_example/sheets_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GSheets',
      home: HomePage(),
    );
  }
}
