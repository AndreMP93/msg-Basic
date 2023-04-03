import 'package:flutter/material.dart';
import 'package:msg_basic/view/LoginView.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
        title: 'msg Basic',
      )
    );
  }
}
