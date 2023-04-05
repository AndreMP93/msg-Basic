import 'AppUser.dart';

class Conversation{
  late AppUser recipent;
  String lastMessage = "";
  int timestamp = -1;
  String messageType = "text";
  int now =  DateTime.now().millisecondsSinceEpoch;

  Conversation({
    required this.recipent,
    this.lastMessage = "",
    this.messageType = "text",
  }) : timestamp = DateTime.now().millisecondsSinceEpoch;

  Conversation.map(Map<String, dynamic> map){
    recipent = AppUser.map(map["recipent"]);
    lastMessage = map["lastMessage"]??"";
    messageType = map["messageType"]?? "text";
    timestamp = map["timestamp"] ?? DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toMap(){
    return {
      "recipent": recipent.toMap(),
      "lastMessage": lastMessage,
      "messageType": messageType,
      "timestamp": timestamp
    };
  }
}