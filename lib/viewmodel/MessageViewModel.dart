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


  Future sendTextMessage(AppUser sender, AppUser recipient, Message msg) async {
    Conversation conversation = Conversation(recipent: recipient, lastMessage: msg.text??"", messageType: MessageTypes.TEXT_MESSAGE);
    msg.timestamp = DateTime.now().millisecondsSinceEpoch;
    if(listaMessages.isEmpty){
      initConversation(sender, recipient, conversation);
    }else{
      updateConversation(sender, recipient, conversation);
    }
    await _db.sendMessage(sender, recipient, msg);
    await _db.sendMessage(recipient, sender, msg);
    initConversation(sender, recipient, conversation);

    await getListMessages(sender, recipient);
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
          print("getListMessages: -> ${listaMessages.length}");
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

  // Future sendImage(AppUser sender, AppUser recipient, File imagemFile) async{
  //   Message msg = Message(idSender: sender.id!);
  //   sendingImage = true;
  //   String result = await _db.sendImageMessage(imagemFile, sender.id!, msg);
  //   sendingImage = false;
  //   if(result.isEmpty){
  //     await sendMessage(sender, recipient, msg);
  //   }else{
  //     errorMessage = result;
  //     sendingImage = false;
  //   }
  //
  // }
}