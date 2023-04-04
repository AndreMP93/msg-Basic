import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msg_basic/helper/ScreenRoutes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/resources/AppColors.dart';
import 'package:msg_basic/viewmodel/AuthUserViewModel.dart';
import 'package:msg_basic/widget/CustomTextField.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';
import 'package:msg_basic/resources/AppStrings.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late AuthUserViewModel _authUserViewModel;
  final _formKey = GlobalKey<FormState>();
  bool _isUserLogged = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _authUserViewModel.checkLoggedUser();
      if(_authUserViewModel.isUserLogging){
        Navigator.pushReplacementNamed(context, ScreenRoutes.HOME_ROUTE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    _authUserViewModel = Provider.of<AuthUserViewModel>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Center(
          child: SingleChildScrollView(
            child: (_authUserViewModel.isUserLogging)
                ?const CircularProgressIndicator(color: Colors.white,)
                : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 150,
                  ),
                  const SizedBox(height: 24,),
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

                      const SizedBox(height: 12,),
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

                  const SizedBox(height: 12,),

                  TextButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        AppUser user = AppUser(email: _emailController.text, password: _passwordController.text);
                        await _login(user);
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
                  const SizedBox(height: 24,),
                  Center(
                    child: GestureDetector(
                      child: const Text(
                        AppStrings.createAnAccountLabel,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, ScreenRoutes.REGISTER_ROUTE);
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

  Future<void> _login(AppUser user) async {
    await _authUserViewModel.login(user);
    if(_authUserViewModel.isUserLogging){
      Navigator.pushReplacementNamed(context, ScreenRoutes.HOME_ROUTE);
    }
  }
}
