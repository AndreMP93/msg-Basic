import 'package:flutter/material.dart';
import 'package:msg_basic/resources/AppColors.dart';
import 'package:msg_basic/widget/CustomTextField.dart';
import 'package:validadores/Validador.dart';
import 'package:msg_basic/resources/AppStrings.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();
  bool _isUserLogged = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Center(
          child: SingleChildScrollView(
            child: (_isUserLogged)
                ?const CircularProgressIndicator()
                : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 150,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      CustomTextField(
                        hintText: AppStrings.emailLabel,
                        controller: _emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          return Validador()
                            .add(Validar.OBRIGATORIO, msg: AppStrings.errorRequiredField)
                            .add(Validar.EMAIL, msg: AppStrings.errorInvalidEmail)
                            .valido(value);
                        },
                      ),

                      const SizedBox(height: 8,),
                      CustomTextField(hintText: AppStrings.passwordLabel,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          return Validador()
                              .add(Validar.OBRIGATORIO, msg: AppStrings.errorRequiredField)
                              .minLength(6, msg: AppStrings.errorInvalidPassword)
                              .valido(value);
                        },
                      ),
                    ],
                    )
                  ),

                  const SizedBox(height: 8,),

                  TextButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){

                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))
                    ),
                    child: const Text(
                      AppStrings.loginButton,
                      style: TextStyle(
                          color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Center(
                    child: GestureDetector(
                      child: const Text(
                        AppStrings.createAnAccountLabel,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
