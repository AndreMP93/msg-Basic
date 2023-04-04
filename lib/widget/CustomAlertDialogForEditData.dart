import 'package:flutter/material.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:msg_basic/widget/CustomInputTextForAlertDialog.dart';

class CustomAlertDialogForEditData extends StatelessWidget {

  final Text title;
  final GlobalKey<FormState> formKey;
  final CustomInputTextForAlertDialog inputTextWidget;
  final Function() updateAdFunction;

  const CustomAlertDialogForEditData({
    required this.title,
    required this. formKey,
    required this.inputTextWidget,
    required this.updateAdFunction,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: inputTextWidget,
      actions: [
        TextButton(
            onPressed: (){Navigator.of(context).pop();},
            child: const Text(AppStrings.cancelButton)
        ),
        TextButton(
            onPressed: ()async{
              if(formKey.currentState!.validate()){
                updateAdFunction();
                Navigator.of(context).pop();
              }
            },
            child: const Text(AppStrings.saveButton)
        )
      ],
    );
  }
}
