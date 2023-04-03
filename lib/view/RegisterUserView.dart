import 'dart:io';

import 'package:flutter/material.dart';
import 'package:msg_basic/helper/GetImage.dart';
import 'package:msg_basic/resources/AppColors.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:msg_basic/widget/CustomTextField.dart';
import 'package:validadores/Validador.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({Key? key}) : super(key: key);

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {

  File? _profilePicture;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.registerUserLabel),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    _selectProfilePicture(context);
                  },
                  child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.2,
                      backgroundImage: (_profilePicture == null)
                          ? null
                          : FileImage(_profilePicture!),
                      child: (_profilePicture != null)
                          ? null
                          : Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.25,
                      )),
                ),
                const SizedBox(height: 16,),
                Form(
                  key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(hintText: AppStrings.userNameLabel,
                          controller: _userNameController,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO, msg: AppStrings.errorRequiredField)
                                .valido(value);
                          },
                        ),
                        const SizedBox(height: 8,),
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
                    AppStrings.registerUserLabel,
                    style: TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _selectProfilePicture(BuildContext buildContext) async {
    return showDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Seleciona uma Foto de Perfil"),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt,  color: AppColors.primaryColor,  size: 40,),
                onPressed: () async {
                  File? image = await GetImage.fromCamera();
                  if (image != null) {
                    Navigator.of(context).pop();
                    setState(() {_profilePicture = File(image.path);});
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon( Icons.photo,  color: AppColors.primaryColor,  size: 40,),
                  onPressed: () async {
                    File? image = await GetImage.fromGallery();
                    if (image != null) {
                      setState(() {
                        _profilePicture = File(image.path);
                        Navigator.of(context).pop();
                      });
                    }
                  },
                ),
              ),
            ],
          );
        });
  }
}
