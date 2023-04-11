import 'dart:io';
import 'package:msg_basic/helper/ImageMessageContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msg_basic/helper/GetImage.dart';
import 'package:msg_basic/helper/MessageTypes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Message.dart';
import 'package:msg_basic/resources/AppColors.dart';
import 'package:msg_basic/view/SendImageView.dart';
import 'package:msg_basic/viewmodel/MessageViewModel.dart';
import 'package:msg_basic/widget/ListMessagesWidget.dart';
import 'package:provider/provider.dart';
import 'package:msg_basic/widget/MessageSendingBox.dart';

class ConversationView extends StatefulWidget {
  final AppUser sender;
  final AppUser recipient;
  const ConversationView({required this.sender, required this.recipient, Key? key}) : super(key: key);

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {

  late MessageViewModel _messageViewModel;
  final List<ImageMessageContent> _imageMessageContent = [];
  final List<Message> _selectedMessages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _messageViewModel.getListMessages(widget.sender, widget.recipient);
    });
  }

  @override
  Widget build(BuildContext context) {

    _messageViewModel = Provider.of<MessageViewModel>(context);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/bg.png"),
                  fit: BoxFit.cover
              ),
            ),)
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            leadingWidth: 23,
            title: (_selectedMessages.isNotEmpty)
                ?Text(_selectedMessages.length.toString())
                :Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.recipient.urlProfilePicture),
                    ),
                    const SizedBox(width: 4,),
                    Text(widget.recipient.name!)
                  ],
                ),
            actions: (_selectedMessages.isNotEmpty)
                ?[IconButton(
                onPressed: () async {
                  for(var msg in _selectedMessages){
                    await _messageViewModel.deleteMessage(widget.sender, widget.recipient, msg);
                  }
                  _selectedMessages.clear();
                },
                icon: Icon(Icons.delete))]
                :[],
          ),

          body: Container(
            color: AppColors.transparent,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: Container(
                  color: AppColors.transparent,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Observer(builder: (_){
                        return ListMessagesWidget(
                          messages: _messageViewModel.listaMessages.toList(),
                          currentUser: widget.sender,
                          selectMessage: _selectMessages,
                          unselectMessage: _unselectMessages,
                          listSelectedMessage: _selectedMessages,
                        );
                      }),
                      MessageSendingBox(sendTextMessage: _sendMessade, sendImageMessage: _selectImages)
                    ],
                  ),
                )
            ),
          ),
        )
      ],
    );
  }

  Future _sendMessade(String text) async {
    Message msg = Message(idSender: widget.sender.id, text: text, messageType: MessageTypes.TEXT_MESSAGE);
    await _messageViewModel.sendMessage(widget.sender, widget.recipient, msg);
  }

  Future _selectImages() async {
    var foto = await GetImage.fromGallery();
    if (foto != null) {
      _imageMessageContent.clear();
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(builder: (_)=>SendImageView(
            image: foto,
            sendImageMessage: _sendImageMessage,
            imageMessageContent: _imageMessageContent,
          )
          )
      );
      // _messageViewModel.sendImageMessage(widget.sender, widget.recipient, foto);
    }
  }

  Future _sendImageMessage(File image, String text) async {
    if(text.isEmpty){
      await _messageViewModel.sendImageMessage(widget.sender, widget.recipient, image);
    }else{
      await _messageViewModel.sendImageMessage(widget.sender, widget.recipient, image, text);
    }
  }

  void _selectMessages(Message msg){
    setState(() {
      _selectedMessages.add(msg);
    });
  }

  void _unselectMessages(Message msg){
    setState(() {
      _selectedMessages.removeWhere((element) => element.id == msg.id);
    });
  }
}
