import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Message.dart';
import 'package:msg_basic/service/constants/AppConstants.dart';

class MessageRepository{
  static final MessageRepository _messageRepositoryInstance = MessageRepository._internal();

  factory MessageRepository(){
    return _messageRepositoryInstance;
  }
  MessageRepository._internal();

  Future<String> sendMessage(AppUser sender, AppUser recipient, Message message) async {
    try{
      String? uId = sender.id;
      String? recipientId = recipient.id;
      if(message.timestamp == -1){
        message.timestamp = Timestamp.now().microsecondsSinceEpoch;
      }
      if(uId != null && recipientId != null){
        final task = await _getMessageRef(uId, recipientId)
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
        await _getMessageRef(uId, recipientId)
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
    return _getMessageRef(sender.id!, recipient.id!)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<String> deleteMessage(AppUser sender, AppUser recipient, Message message) async{
    try{
      String? uId = sender.id;
      String? recipientId = recipient.id;
      if(uId != null && recipientId != null) {
        await _getMessageRef(uId, recipientId)
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
      final fileRef = FirebaseStorage.instance.refFromURL(urlPhoto);
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
      final pastaRaiz = FirebaseStorage.instance.ref();
      final arquivo = pastaRaiz.child(AppConstants.IMG_MESSAGE_PATH)
          .child(sender.id!)
          .child(recipient.id!)
          .child("$imageName.jpg");
      UploadTask? task = arquivo.putFile(imagem);
      final TaskSnapshot snapshot = await task.whenComplete(() => null);
      String urlImage = await snapshot.ref.getDownloadURL();
      return urlImage;
    }catch (e){
      print("ERrro: uploadImageMessage -> $e");
      return "";
    }
  }

  CollectionReference<Map<String,dynamic>> _getMessageRef(String senderId, String recipientId){
    return FirebaseFirestore.instance
        .collection(AppConstants.USER_COLLECTION)
        .doc(senderId)
        .collection(AppConstants.CONVERSATION_COLLECTION)
        .doc(recipientId)
        .collection(AppConstants.MESSAGES_COLLECTION);
  }
}