import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:msg_basic/helper/ScreenRoutes.dart';
import 'package:msg_basic/resources/AppTheme.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.mainTheme,
      initialRoute: "/",
      onGenerateRoute: ScreenRoutes.generateRoutes,
    );
  }
}
