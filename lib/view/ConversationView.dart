import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msg_basic/helper/GetImage.dart';
import 'package:msg_basic/helper/MessageTypes.dart';
import 'package:msg_basic/model/AppUser.dart';
import 'package:msg_basic/model/Message.dart';
import 'package:msg_basic/resources/AppColors.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //await _messageViewModel.getListMessages(widget.sender, widget.recipient);
    });
  }

  @override
  Widget build(BuildContext context) {

    _messageViewModel = Provider.of<MessageViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipient.name!),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(image: AssetImage("imagens/bg.png"),
        //       fit: BoxFit.cover
        //   ),
        // ),
        child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Observer(builder: (_){
                    return ListMessagesWidget(
                        messages: _messageViewModel.listaMessages,
                        currentUser: widget.sender);
                  }),
                  MessageSendingBox(sendTextMessage: _sendMessade, sendImageMessage: _sendImageMessage)
                ],
              ),
            )
        ),
      ),
    );
  }

  Future _sendMessade(String text) async {
    Message msg = Message(idSender: widget.sender.id, text: text, messageType: MessageTypes.TEXT_MESSAGE);
    await _messageViewModel.sendTextMessage(widget.sender, widget.recipient, msg);
  }

  Future _sendImageMessage() async {
    var foto = await GetImage.fromGallery();
    if (foto != null) {

    }
  }
}
