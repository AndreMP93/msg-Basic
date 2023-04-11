import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:msg_basic/helper/FormatTimestamp.dart';
import 'package:msg_basic/helper/MessageTypes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Message.dart';
import 'package:msg_basic/resources/AppColors.dart';

class ListMessagesWidget extends StatefulWidget {

  final List<Message> messages;
  final AppUser currentUser;
  final Function(Message) selectMessage;
  final Function(Message) unselectMessage;
  final List<Message> listSelectedMessage;

  const ListMessagesWidget({
    required this.messages,
    required this.currentUser,
    required this.selectMessage,
    required this.unselectMessage,
    required this.listSelectedMessage,
    Key? key}) : super(key: key);

  @override
  State<ListMessagesWidget> createState() => _ListMessagesWidgetState();
}

class _ListMessagesWidgetState extends State<ListMessagesWidget> {
  bool isSelectedMessage = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            reverse: true,
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              bool isMyMessage =
              (widget.currentUser.id == widget.messages[index].idSender);
              return Container(
                color: (widget.messages[index].isSelected)? AppColors.selectedMessageColor: AppColors.transparent,
                child: Align(
                  alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: IntrinsicWidth(
                        child: _messageBallonWidget(widget.messages[index], isMyMessage),
                      )
                  ),
                ),
              );
            }));
  }

  Widget _messageBallonWidget(Message message, bool isMyMessage) {
    Color color = (isMyMessage) ? Color(0xffbdacff) : Color(0xfff9f8ff);
    return GestureDetector(
      onTap: (){
        if(widget.listSelectedMessage.isNotEmpty){
          if(message.isSelected){
            widget.unselectMessage(message);
          }else{
            widget.selectMessage(message);
          }
          message.isSelected = !message.isSelected;
        }
      },
      onLongPress: (){
        if(widget.listSelectedMessage.isEmpty){
          widget.selectMessage(message);
          setState(() {
            message.isSelected = true;
          });
        }
        },
      child: ChatBubble(
          clipper: (isMyMessage)
              ? ChatBubbleClipper2(type: BubbleType.sendBubble)
              : ChatBubbleClipper2(type: BubbleType.receiverBubble),
          alignment:
          (isMyMessage) ? Alignment.centerLeft : Alignment.center,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          backGroundColor: color,
          child: Container(
            padding: (isMyMessage)
                ? const EdgeInsets.fromLTRB(5, 5, 20, 5)
                : const EdgeInsets.fromLTRB(20, 5, 5, 5),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              children: [
                _getMessageContent(message),
                const SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: (isMyMessage)
                      ?MainAxisAlignment.end
                      :MainAxisAlignment.start,
                  children: [
                    Text(
                      FormatTimestamp.getTimeFromTimestamp(message.timestamp.toString()),
                      style: const TextStyle(fontSize: 12),),
                    (isMyMessage)
                        ? const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(Icons.done_all, size: 15,),)
                        :Container()
                  ],
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _getMessageContent(Message msg){
    switch(msg.messageType!){
      case MessageTypes.TEXT_MESSAGE:
        return Text(msg.text!, style: const TextStyle(color: Colors.black,));

      case MessageTypes.IMAGE_MESSAGE:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
                maxHeight: MediaQuery.of(context).size.width * 0.65,
                minWidth: MediaQuery.of(context).size.width * 0.25,
                minHeight: MediaQuery.of(context).size.width * 0.25,
              ),
              child: (msg.urlImage!.isNotEmpty)
                  ? Image.network(msg.urlImage!)
                  : Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: const Center(child: CircularProgressIndicator(),)
                ),
            ),
            (msg.text!.isNotEmpty)
                ? Container(padding: const EdgeInsets.only(top: 4, left: 4), child: Text(msg.text!),)
                :Container()
          ],
        );

      default:
        return Container();
    }
  }


}
