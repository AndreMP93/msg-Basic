import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/service/CloudDataBase.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/resources/AppStrings.dart';

part 'RegisterUserViewModel.g.dart';

class RegisterUserViewModel = _RegisterUserViewModel with _$RegisterUserViewModel;

abstract class _RegisterUserViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  @observable
  String errorMessage = "";
  @observable
  bool isRegisteringUser = false;

  @action
  Future registerUser(AppUser user, File? image) async {
    isRegisteringUser = true;
    try{
      if (image != null && user.id != null) {
        UploadTask? uploadTask = await _db.uploadProfilePicture(image, user.id!);
        if (uploadTask != null) {
          final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
          user.urlProfilePicture = await snapshot.ref.getDownloadURL();
        }
      }
      String result = await _db.registerUserData(user);
      if (result.isNotEmpty) {
        errorMessage = result;
      }
    }catch(e){
      errorMessage = "${AppStrings.registerUserError}: $e";
    }
    isRegisteringUser = false;
  }
}