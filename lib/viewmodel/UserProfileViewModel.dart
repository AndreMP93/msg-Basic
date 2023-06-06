import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/model/ResultModel.dart';
import 'package:msg_basic/service/CloudDataBase.dart';
import 'package:msg_basic/service/repository/UserRepository.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/resources/AppStrings.dart';
part 'UserProfileViewModel.g.dart';

class UserProfileViewModel = _UserProfileViewModel with _$UserProfileViewModel;

abstract class _UserProfileViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  final UserRepository _userRepository = UserRepository();

  @observable
  bool uploadingImage = false;
  @observable
  String errorMessage = "";
  @observable
  AppUser? userData;

  @action
  Future getUser(AppUser user) async{
    final result = await _userRepository.getUserData(user.id!);
    if(result.isSuccess){
      userData = result.data;
    }else{
      errorMessage = result.message;
    }
  }

  Future updateUserData(AppUser user) async {
    ResultModel result = await _userRepository.updateUserData(user);
    if(result.isSuccess){
      await getUser(user);
    }else{
      errorMessage = result.message;
    }
  }

  Future updateProfilePhoto(File imagem, AppUser user) async {
    uploadingImage = true;
    try {
      UploadTask? task = await _userRepository.uploadProfilePicture(imagem, user.id!);
      if(task != null){
        task.snapshotEvents.listen((event) {
          if(event.state == TaskState.running){
            uploadingImage = true;
          }else if(event.state == TaskState.error){
            errorMessage = AppStrings.errorUpdateProfilePhoto;
          }
        });
        final TaskSnapshot snapshot = await task.whenComplete(() => null);
        userData?.urlProfilePicture = await snapshot.ref.getDownloadURL();
        await updateUserData(userData!);
      }else{
        errorMessage = AppStrings.errorUpdateProfilePhoto;
      }
    }catch(error){
      print("ERROR: ${AppStrings.errorUpdateProfilePhoto} -> $error");
      errorMessage = AppStrings.errorUpdateProfilePhoto;
    }
    uploadingImage = false;
  }

}