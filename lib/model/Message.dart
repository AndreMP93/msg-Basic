import 'dart:io';

class Message{
  late String? id;
  String? messageType;
  String? idSender;
  String? text;
  String? urlImage;
  int timestamp =-1;
  bool isSelected = false;
  Message({
    required this.idSender,
    this.id,
    this.messageType,
    this.text,
    this.urlImage,
    this.timestamp =-1
  });

  Message.map(Map<String, dynamic> map){
    id = map["id"];
    idSender = map["idUsuario"];
    messageType = map["messageType"];
    text = map["texto"]??"";
    urlImage = map["urlFoto"];
    timestamp = map["timestamp"]??1;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id": id,
      "idUsuario" : idSender,
      "messageType": messageType,
      "texto" : text,
      "urlFoto" : urlImage,
      "timestamp" : timestamp
    };
    return map;
  }

}