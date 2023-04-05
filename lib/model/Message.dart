class Message{
  late String _idMessage;
  String? messageType;
  String? idSender;
  String? text;
  String? urlImage;
  int timestamp =-1;

  Message({
    required this.idSender,
    this.messageType,
    this.text,
    this.urlImage,
    this.timestamp =-1
  });

  Message.map(Map<String, dynamic> map){
    idSender = map["idUsuario"];
    messageType = map["messageType"];
    text = map["texto"]??"";
    urlImage = map["urlFoto"];
    timestamp = map["timestamp"]??1;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario" : idSender,
      "messageType": messageType,
      "texto" : text,
      "urlFoto" : urlImage,
      "timestamp" : timestamp
    };
    return map;
  }

  String get idMessage => _idMessage;

  set idMessage(String value) {
    _idMessage = value;
  }

}