import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/helper/MessageTypes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Message.dart';

class ListMessagesWidget extends StatefulWidget {
  List<Message> messages;
  AppUser currentUser;
  ListMessagesWidget({required this.messages, required this.currentUser, Key? key})
      : super(key: key);

  @override
  State<ListMessagesWidget> createState() => _ListMessagesWidgetState();
}

class _ListMessagesWidgetState extends State<ListMessagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            reverse: true,
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              bool isMyMessage =
              (widget.currentUser.id == widget.messages[index].idSender);
              return Align(
                alignment:
                isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IntrinsicWidth(
                      child: _messageBallonWidget(
                          widget.messages[index], isMyMessage),
                    )
                ),
              );
            }));
  }

  Widget _messageBallonWidget(Message message, bool isMyMessage) {
    Color color = (isMyMessage) ? Color(0xffbdacff) : Color(0xfff9f8ff);
    if (message.messageType == MessageTypes.TEXT_MESSAGE) {
      return ChatBubble(
          clipper: (isMyMessage)
              ? ChatBubbleClipper2(type: BubbleType.sendBubble)
              : ChatBubbleClipper2(type: BubbleType.receiverBubble),
          // alignment:
          // (isMyMessage) ? Alignment.centerLeft : Alignment.center,
          // padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          backGroundColor: color,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message.text!,
              style: TextStyle(color: Colors.black,),
            ),
          )
      );
    } else {
      return ChatBubble(
        clipper: (isMyMessage)
            ? ChatBubbleClipper2(type: BubbleType.sendBubble)
            : ChatBubbleClipper2(type: BubbleType.receiverBubble),
        alignment: (isMyMessage) ? Alignment.centerRight : Alignment.centerLeft,
        // margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(0),
        // margin: EdgeInsets.all(0),
        backGroundColor: color,
        child: Center(
          child: BubbleNormalImage(
            id: 'id001',
            image: Image.network(message.urlImage!),
            color: color,
            tail: true,
            isSender: !isMyMessage,
            delivered: false,
          ),
        ),
      );
    }
  }
}
