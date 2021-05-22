import 'package:flutter/material.dart';
import 'package:openwp/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            textTheme: TextTheme(
                headline6: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ))),
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
