import 'package:flutter/material.dart';

class MessageSendingBox extends StatefulWidget {

  final Function(String) sendTextMessage;
  final Function() sendImageMessage;

  const MessageSendingBox({
    required this.sendTextMessage,
    required this.sendImageMessage,
    Key? key}) : super(key: key);

  @override
  State<MessageSendingBox> createState() => _MessageSendingBoxState();
}

class _MessageSendingBoxState extends State<MessageSendingBox> {
  final TextEditingController _messageController = TextEditingController();
  bool sendMessage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: _messageController,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.fromLTRB(32, 8, 0, 8),
                    hintText: "Digite a sua mensagem!",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () async {
                        if(!sendMessage){
                          await widget.sendImageMessage();
                        }
                      },
                    )
                ),
              ),
            ),
          ),
          FloatingActionButton(
              backgroundColor: const Color(0xff7260d4),
              mini: true,
              onPressed: () async {

                if(!sendMessage){
                  sendMessage = true;
                  await widget.sendTextMessage(_messageController.text);
                  _messageController.clear();
                  sendMessage = false;
                }
              },
              child: const Icon(Icons.send, color: Colors.white,)
          )
        ],
      ),
    );
  }
}
