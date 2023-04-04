import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/resources/AppStrings.dart';

class CloudDataBase {
  static final CloudDataBase _dataSourceSingleton = CloudDataBase._internal();
  final _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;
  final String _userCollection = "users";
  final String _convesationsCollection = "convesations";
  final String _messagesCollection = "messages";
  final String _profilePicturePath = "profile";
  final String _imgMessagePath = "imgMessage";

  factory CloudDataBase(){
    return _dataSourceSingleton;
  }

  CloudDataBase._internal();

  Future<AppUser?> getUserData(String userId) async {
    try{
      final result = await _fireStore.collection(_userCollection).doc(userId).get();
      if(result.data()!=null){
        Map<String, dynamic> map = result.data()!;
        AppUser appUser = AppUser.map(map);
        return appUser;
      }
      return null;
    }catch(error){
      print("ERROR: getUserData() $error");
      return null;
    }
  }

  Future<String> updateUserData(AppUser user) async {
    try{
      String? userId = user.id;
      if (userId != null){
        await _fireStore.collection(_userCollection).doc(userId).update(user.toMap());
        return "";
      }
      return AppStrings.userLoggedOut;
    }catch(error){
      print("ERROR: updateUserData() -> ${AppStrings.updateDataUserError} $error");
      return "${AppStrings.updateDataUserError}:: $error";
    }
  }

  Future<String> registerUserData(AppUser user) async {
    try{
      String? userId = user.id;
      if(userId!= null){
        await _fireStore
            .collection(_userCollection)
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

  Future<UploadTask?> uploadProfilePicture(File imagem, String userID) async {
    try{
      final pastaRaiz = _storageInstance.ref();
      final arquivo = pastaRaiz.child(_profilePicturePath).child("$userID.jpg");
      return arquivo.putFile(imagem);
    }catch (e){
      return null;
    }
  }

  Future<UploadTask?> updataProfilePicture(File imagem, AppUser user) async {
    try{
      String result = await deletePhoto(user.urlProfilePicture);
      if(result.isEmpty){
        final pastaRaiz = _storageInstance.ref();
        final arquivo = pastaRaiz.child(_profilePicturePath).child("${user.id}.jpg");
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
      final fileRef = _storageInstance.refFromURL(urlPhoto);
      await fileRef.delete();
      return "";
    } catch (e) {
      print("Erro ao deletar imagem: $e");
      return "Erro ao deletar imagem: $e";
    }
  }
}