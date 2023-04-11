import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Conversation.dart';
import 'package:msg_basic/model/Message.dart';
import 'package:msg_basic/resources/AppStrings.dart';

class CloudDataBase {
  static final CloudDataBase _dataSourceSingleton = CloudDataBase._internal();
  final _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;
  final String _userCollection = "users";
  final String _conversationsCollection = "conversations";
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

  Future<List<AppUser>> getAllUsers() async {
    List<AppUser> users = [];
    try{
      final result = await _fireStore.collection(_userCollection).orderBy("name").get();
      for(var document in result.docs){
        AppUser user = AppUser.map(document.data());
        users.add(user);
      }
    }catch(error){
      print("ERROR: getAllUsers() -> $error");
    }
    return users;
  }

  Future<Stream<QuerySnapshot>?> getAllUserConversations(AppUser user) async {
    try{
      return await _fireStore
          .collection(_userCollection)
          .doc(user.id)
          .collection(_conversationsCollection)
          .orderBy('timestamp', descending: true)
          .snapshots();
    }catch (error){
      print("ERROR: getAllUserCoversations");
    }
    return null;
  }

  Future<String> createConversation(AppUser sender, AppUser recipient, Conversation conversation) async {
    try{
      await _fireStore.collection(_userCollection)
          .doc(sender.id)
          .collection(_conversationsCollection)
          .doc(recipient.id)
          .set(conversation.toMap());
      return "";
    }catch (e){
      print("ERROR: createConversation() -> \n$e");
      return e.toString();
    }
  }

  Future<String> updateConversation(AppUser sender, AppUser recipient, Conversation conversation) async {
    try{
      String? uId = sender.id;
      String? recipientId = recipient.id;
      if (uId != null && recipientId != null){
        await _fireStore
            .collection(_userCollection)
            .doc(uId)
            .collection(_conversationsCollection)
            .doc(recipientId)
            .update(conversation.toMap());
        return "";
      }
      return "Verifique se o usuario está logado";
    }catch(error){
      print("ERRoR: updateConversation() -> $error");
      return "Falha ao atualizar dados do Usuário: $error";
    }
  }

  Future<String> deleteConversation(AppUser sender, AppUser recipient) async {
    try{
      await _fireStore.collection(_userCollection)
          .doc(sender.id)
          .collection(_conversationsCollection)
          .doc(recipient.id)
          .delete();
      return "";
    }catch (e){
      print("ERROR: deleteConversation() -> \n$e");
      return e.toString();
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

  Future<String> sendMessage(AppUser sender, AppUser recipient, Message message) async {
    try{
      String? uId = sender.id;
      String? recipientId = recipient.id;
      if(message.timestamp == -1){
        message.timestamp = Timestamp.now().microsecondsSinceEpoch;
      }
      if(uId != null && recipientId != null){
        final task = await _fireStore
            .collection(_userCollection)
            .doc(uId)
            .collection(_conversationsCollection)
            .doc(recipientId)
            .collection(_messagesCollection)
            .add(message.toMap());
        message.id = task.id;
        updateMessage(sender, recipient, message);
        return "";
      }
    }catch (e){
      print("Falha ao enviar a sua mensagem.\n$e");
    }
    return "Falha ao enviar a sua mensagem.";
  }

  Future<String> updateMessage(AppUser sender, AppUser recipient, Message message) async {
    try{
      String? uId = sender.id;
      String? recipientId = recipient.id;
      if(uId != null && recipientId != null){
        await _fireStore
            .collection(_userCollection)
            .doc(uId)
            .collection(_conversationsCollection)
            .doc(recipientId)
            .collection(_messagesCollection)
            .doc(message.id)
            .update(message.toMap());
        return "";
      }

    }catch (e){
      print("ERROR: Erro ao atualizar os dados da mensagem -> $e");
    }
    return "ERROR: Erro ao atualizar os dados da mensagem.";
  }

  Future<Stream<QuerySnapshot>> getListMessagesStream(AppUser sender, AppUser recipient) async {
    return _fireStore
        .collection(_userCollection)
        .doc(sender.id)
        .collection(_conversationsCollection)
        .doc(recipient.id)
        .collection(_messagesCollection)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<String> deleteMessage(AppUser sender, AppUser recipient, Message message) async{
    try{
      String? uId = sender.id;
      String? recipientId = recipient.id;
      if(uId != null && recipientId != null) {
        await _fireStore
            .collection(_userCollection)
            .doc(uId)
            .collection(_conversationsCollection)
            .doc(recipientId)
            .collection(_messagesCollection)
            .doc(message.id).delete();
        return "";
      }
      return "Falha ao deletar mensagem.";
    }catch (e){
      return "Falha ao deletar mensagem.";
    }
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

  Future<String> uploadImageMessage(File imagem, AppUser sender, AppUser recipient) async {
    try{
      String imageName = DateTime.now().microsecondsSinceEpoch.toString();
      final pastaRaiz = _storageInstance.ref();
      final arquivo = pastaRaiz.child(_imgMessagePath).child(sender.id!).child(recipient.id!).child("$imageName.jpg");
      UploadTask? task = arquivo.putFile(imagem);
      final TaskSnapshot snapshot = await task.whenComplete(() => null);
      String urlImage = await snapshot.ref.getDownloadURL();
      return urlImage;
    }catch (e){
     print("ERrro: uploadImageMessage -> $e");
      return "";
    }
  }
}