import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/helper/MessageTypes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Conversation.dart';
import 'package:msg_basic/resources/AppColors.dart';

class ConversationTab extends StatefulWidget {
  final ObservableList<Conversation> conversations;
  final Function(AppUser) onTap;
  final Function(Conversation) selectConversation;
  final Function(Conversation) unselectConversation;
  final List<Conversation> selectedConversations;
  const ConversationTab({
    required this.conversations,
    required this.onTap,
    required this.selectConversation,
    required this.unselectConversation,
    required this.selectedConversations,
    Key? key
  }) : super(key: key);

  @override
  State<ConversationTab> createState() => _ConversationTabState();
}

class _ConversationTabState extends State<ConversationTab> {



  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_){
          return Container(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: widget.conversations.length,
                itemBuilder: (context, index){
                  Conversation conversation = widget.conversations[index];
                  return Container(
                    // padding: const EdgeInsets.only(top: 5),
                    color: (conversation.isSelected)? AppColors.selectedMessageColor: AppColors.transparent,
                    child: ListTile(
                      title: Text(conversation.recipent.name!, maxLines: 1, style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      subtitle: _subtitleConversation(conversation),
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(conversation.recipent.urlProfilePicture)
                      ),
                      onTap: (){
                        if(widget.selectedConversations.isEmpty){
                          widget.onTap(conversation.recipent);
                        }else{
                          if(conversation.isSelected){
                            setState(() {
                              widget.unselectConversation(conversation);
                              conversation.isSelected = false;
                            });
                          }else{
                            setState(() {
                              conversation.isSelected = true;
                              widget.selectConversation(conversation);
                            });
                          }
                        }
                      },
                      onLongPress: (){
                        if(widget.selectedConversations.isEmpty){
                          setState(() {
                            conversation.isSelected = true;
                            widget.selectConversation(conversation);
                          });
                        }

                      },
                    ),
                  );
                }
            ),
          );
        }
    );
  }
  
  _subtitleConversation(Conversation conversation){
    switch(conversation.messageType){
      case MessageTypes.TEXT_MESSAGE:
        return Text(conversation.lastMessage, maxLines: 1,);
        
      case MessageTypes.IMAGE_MESSAGE:
        if(conversation.lastMessage.isEmpty){
          return Row(
            children: const [
              Icon(Icons.photo, size: 18,),
              SizedBox(width: 3,),
              Text("Foto")
            ],
          );
        }else{
          return Row(
            children: [
              const Icon(Icons.photo),
              const SizedBox(width: 3,),
              Text(conversation.lastMessage, maxLines: 1,)
            ],
          );
        }
    }
  }
}
