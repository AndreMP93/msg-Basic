import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:msg_basic/helper/ScreenRoutes.dart';
import 'package:msg_basic/resources/AppTheme.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:msg_basic/viewmodel/AuthUserViewModel.dart';
import 'package:msg_basic/viewmodel/RegisterUserViewModel.dart';
import 'package:msg_basic/viewmodel/UserProfileViewModel.dart';
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
    return MultiProvider(
        providers: [
          Provider<AuthUserViewModel>(create: (_)=> AuthUserViewModel()),
          Provider<RegisterUserViewModel>(create: (_)=> RegisterUserViewModel()),
          Provider<UserProfileViewModel>(create: (_)=> UserProfileViewModel()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: AppTheme.mainTheme,
        initialRoute: "/",
        onGenerateRoute: ScreenRoutes.generateRoutes,
      ),
    );
  }
}
