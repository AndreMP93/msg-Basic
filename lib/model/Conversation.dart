import 'AppUser.dart';

class Conversation{
  String lastMessage = "";
  int timestamp = -1;
  int now =  DateTime.now().millisecondsSinceEpoch;

  Conversation({
    this.lastMessage = "",
  }) : timestamp = DateTime.now().millisecondsSinceEpoch;

  Conversation.map(Map<String, dynamic> map){
    lastMessage = map["lastMessage"]??"";
    timestamp = map["timestamp"] ?? DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toMap(){
    return {
      "lastMessage": lastMessage,
      "timestamp": timestamp
    };
  }
}