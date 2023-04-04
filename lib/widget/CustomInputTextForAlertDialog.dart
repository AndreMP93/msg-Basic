import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:validadores/Validador.dart';

class CustomInputTextForAlertDialog extends StatelessWidget {

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const CustomInputTextForAlertDialog({
    required this.formKey,
    required this.controller,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          validator: (value) {
            return Validador()
                .add(Validar.OBRIGATORIO, msg: AppStrings.errorRequiredField)
                .maxLength(100, msg: AppStrings.errorMaxLength100)
                .valido(value);
          },
        )
    );
  }
}
