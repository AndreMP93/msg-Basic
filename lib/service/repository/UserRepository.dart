import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/ResultModel.dart';
import 'package:msg_basic/resources/AppStrings.dart';
import 'package:msg_basic/service/constants/AppConstants.dart';

class UserRepository{
  static final UserRepository _userRepositoryInstance = UserRepository._internal();

  factory UserRepository(){
    return _userRepositoryInstance;
  }
  UserRepository._internal();

  Future<ResultModel<AppUser>> getUserData(String userId) async {
    try{
      var result = ResultModel<AppUser>.loading();
      await _getUserRef()
          .doc(userId)
          .get()
          .then((value){
        var map = value.data();
        if(map != null){
          result = ResultModel.success(AppUser.map(map));
        }else{
          result =  ResultModel.error(AppStrings.errorGettingUserData);
        }
      });
      return result;
    }catch(error){
      print("ERROR: getUserData() $error");
      return ResultModel.error(error.toString());
    }
  }

  Future<ResultModel<void>> updateUserData(AppUser user) async {
    try{
      String? userId = user.id;
      var resultUpdate = ResultModel.loading();
      if (userId != null){
        await _getUserRef()
            .doc(userId)
            .update(user.toMap()).then((value) => {
          resultUpdate = ResultModel.success(Null)
        }).onError((error, stackTrace) => {
          resultUpdate = ResultModel.error(AppStrings.updateDataUserError)
        });
      }
      return resultUpdate;
    }catch(error){
      print("ERROR: updateUserData() -> ${AppStrings.updateDataUserError} $error");
      return ResultModel.error("${AppStrings.updateDataUserError}: $error");
    }
  }

  Future<String> registerUserData(AppUser user) async {
    try{
      String? userId = user.id;
      if(userId!= null){
        await _getUserRef()
            .doc(userId)
            .set(user.toMap());
        return "";
      }
      return AppStrings.registerUserError;
    }catch(onError){
      print("ERROR: registerUserData() -> ${AppStrings.registerUserError}: $onError");
      return "${AppStrings.registerUserError}: $onError";
    }
  }

  Future<List<AppUser>> getAllUsers() async {
    List<AppUser> users = [];
    try{
      final result = await _getUserRef().orderBy("name").get();
      for(var document in result.docs){
        AppUser user = AppUser.map(document.data());
        users.add(user);
      }
    }catch(error){
      print("ERROR: getAllUsers() -> $error");
    }
    return users;
  }

  Future<UploadTask?> uploadProfilePicture(File imagem, String userID) async {
    try{
      final pastaRaiz = _getStorangeRef();
      final arquivo = pastaRaiz.child(AppConstants.PROFILE_PICTURE_PATH).child("$userID.jpg");
      return arquivo.putFile(imagem);
    }catch (e){
      return null;
    }
  }

  Future<UploadTask?> updataProfilePicture(File imagem, AppUser user) async {
    try{
      String result = await deletePhoto(user.urlProfilePicture);
      if(result.isEmpty){
        final pastaRaiz = _getStorangeRef();
        final arquivo = pastaRaiz.child(AppConstants.PROFILE_PICTURE_PATH).child("${user.id}.jpg");
        return arquivo.putFile(imagem);
      }
    }catch (e){
      print("Error: updataProfilePicture() -> $e");
      return null;
    }
    return null;
  }

  Future<String> deletePhoto(String urlPhoto) async {
    try {
      final fileRef = FirebaseStorage.instance.refFromURL(urlPhoto);
      await fileRef.delete();
      return "";
    } catch (e) {
      print("Erro ao deletar imagem: $e");
      return "Erro ao deletar imagem: $e";
    }
  }

  CollectionReference<Map<String,dynamic>> _getUserRef(){
    return FirebaseFirestore.instance.collection(AppConstants.USER_COLLECTION);
  }

  Reference _getStorangeRef(){
    return FirebaseStorage.instance.ref();
  }
}