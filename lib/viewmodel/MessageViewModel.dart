import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/firebase/CloudDataBase.dart';
import 'package:msg_basic/helper/MessageTypes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Conversation.dart';
import 'package:msg_basic/model/Message.dart';
part 'MessageViewModel.g.dart';

class MessageViewModel = _MessageViewModel with _$MessageViewModel;

abstract class _MessageViewModel with Store{
  final CloudDataBase _db = CloudDataBase();
  ObservableList<Message> listaMessages = ObservableList();
  @observable
  bool loadindAllMessages = true;
  @observable
  bool sendingImage = false;
  @observable
  String errorMessage = "";
  @observable
  StreamSubscription<QuerySnapshot>? _messageStream;


  Future sendMessage(AppUser sender, AppUser recipient, Message msg) async {
    if(msg.text != null && msg.text!.isNotEmpty){
      Conversation conversation = Conversation(recipent: recipient, lastMessage: msg.text??"", messageType: MessageTypes.TEXT_MESSAGE);
      msg.timestamp = DateTime.now().millisecondsSinceEpoch;
      if(listaMessages.isEmpty){
        initConversation(sender, recipient, conversation);
      }else{
        updateConversation(sender, recipient, conversation);
      }
      await _db.sendMessage(sender, recipient, msg);
      await _db.sendMessage(recipient, sender, msg);
    }
    // initConversation(sender, recipient, conversation);

  }

  Future getListMessages(AppUser sender, AppUser recipient) async{
    if(_messageStream !=null){
      _messageStream!.cancel();
    }
    Stream<QuerySnapshot> snapshot  = await _db.getListMessagesStream(sender, recipient);
    _messageStream = snapshot.listen(
            (event) async {
          listaMessages.clear();
          List<Message> messages = await Future.wait(event.docs.map((document) async {
            Message msg = Message.map(document.data() as Map<String, dynamic>);
            return msg;
          }).toList());
          listaMessages.addAll(messages);
        }
    );
  }

  Future initConversation(AppUser sender, AppUser recipient, Conversation conversation) async {
    await _db.createConversation(sender, recipient, conversation);
    conversation.recipent = sender;
    await _db.createConversation(recipient, sender, conversation);
    conversation.recipent = recipient;
  }

  Future updateConversation(AppUser sender, AppUser recipient, Conversation conversation) async {
    await _db.updateConversation(sender, recipient, conversation);
    conversation.recipent = sender;
    await _db.updateConversation(recipient, sender, conversation);
    conversation.recipent = recipient;
  }

  Future sendImageMessage(AppUser sender, AppUser recipient, File imagemFile, [String text = ""]) async{
    sendingImage = true;
    Message msg = Message(idSender: sender.id, messageType: MessageTypes.IMAGE_MESSAGE, urlImage: "", text: text);
    msg.timestamp = DateTime.now().millisecondsSinceEpoch;
    Conversation conversation = Conversation(recipent: recipient, lastMessage: msg.text??"", messageType: MessageTypes.IMAGE_MESSAGE);
    if(listaMessages.isNotEmpty){
      await _db.createConversation(sender, recipient, conversation);
    }else{
      await _db.createConversation(sender, recipient, conversation);
    }
    String resultSend = await _db.sendMessage(sender, recipient, msg);
    if(resultSend.isEmpty){
      String result = await _db.uploadImageMessage(imagemFile, sender, recipient);
      if(result.isNotEmpty){
        msg.urlImage = result;
        await _db.updateMessage(sender, recipient, msg);
        await _db.createConversation(recipient, sender, conversation);
        await _db.sendMessage(recipient, sender, msg);
      }
    }
    sendingImage = false;
  }

  Future<void> deleteMessage(AppUser sender, AppUser recipient, Message msg) async {
    String result = await _db.deleteMessage(sender, recipient, msg);
    if(result.isEmpty){
      listaMessages.removeWhere((element) => element.id == msg.id);
    }
  }
}