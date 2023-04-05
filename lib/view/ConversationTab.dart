import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Conversation.dart';

class ConversationTab extends StatefulWidget {
  final ObservableList<Conversation> conversations;
  final Function(AppUser) onTap;
  const ConversationTab({required this.conversations, required this.onTap, Key? key}) : super(key: key);

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
                    child: ListTile(
                      title: Text(conversation.recipent.name!, maxLines: 1, style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      subtitle: Text(conversation.lastMessage, maxLines: 1,),
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(conversation.recipent.urlProfilePicture)
                      ),
                      onTap: (){
                        widget.onTap(conversation.recipent);
                      },
                    ),
                  );
                }
            ),
          );
        }
    );
  }
}
