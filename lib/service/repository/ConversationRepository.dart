import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Conversation.dart';
import 'package:msg_basic/service/constants/AppConstants.dart';

class ConversationRepository{
  static final ConversationRepository _conversationRepositoryInstance = ConversationRepository._internal();

  factory ConversationRepository(){
    return _conversationRepositoryInstance;
  }
  ConversationRepository._internal();

  Future<String> createConversation(AppUser sender, AppUser recipient, Conversation conversation) async {
    try{
      await _getConversationRef(sender.id!)
          .doc(recipient.id!)
          .set(conversation.toMap());
      return "";
    }catch (e){
      print("ERROR: createConversation() -> \n$e");
      return e.toString();
    }
  }

  Stream<List<Conversation>>? getAllUserConversations(AppUser user)  {
    try{
      return  _getConversationRef(user.id!)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((document) {
        Conversation conversation =
        Conversation.map(document.data() as Map<String, dynamic>);
        return conversation;
      }).toList());
    }catch (error){
      print("ERROR: getAllUserCoversations");
    }
    return null;
  }

  Future<String> updateConversation(AppUser sender, AppUser recipient, Conversation conversation) async {
    try{
      String? uId = sender.id;
      String? recipientId = recipient.id;
      if (uId != null && recipientId != null){
        await _getConversationRef(uId)
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
      await _getConversationRef(sender.id!)
          .doc(recipient.id)
          .delete();
      return "";
    }catch (e){
      print("ERROR: deleteConversation() -> \n$e");
      return e.toString();
    }
  }
  
  CollectionReference<Map<String,dynamic>> _getConversationRef(String userID){
    return FirebaseFirestore.instance.collection(AppConstants.USER_COLLECTION)
        .doc(userID)
        .collection(AppConstants.CONVERSATION_COLLECTION);
  }
}