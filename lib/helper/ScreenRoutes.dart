// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:msg_basic/view/HomeView.dart';
import 'package:msg_basic/view/LoginView.dart';
import 'package:msg_basic/view/RegisterUserView.dart';
import 'package:msg_basic/view/UserProfileView.dart';

class ScreenRoutes{
  static const String LOGIN_ROUTE = "/login";
  static const String REGISTER_ROUTE = "/register";
  static const String HOME_ROUTE = "/home";
  static const String USER_PROFILE = "/user-profile";

  static Route<dynamic> generateRoutes(RouteSettings setting){
    switch(setting.name){
      case "/":
        return MaterialPageRoute(builder: (_)=> const LoginView());

      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_)=> LoginView());

      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_)=> RegisterUserView());

      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_)=> const HomeView());

      case USER_PROFILE:
        return MaterialPageRoute(builder: (_)=> UserProfileView());

    default:
      return _erroRota();
    }
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(
        title: const Text("Tela Não Encontrada!"),
      ),
      body: const Center(
        child: Text("Tela Não Encontrada!"),
      ),
    ));
  }

}