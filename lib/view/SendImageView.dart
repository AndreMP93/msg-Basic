import 'dart:io';
import 'package:flutter/material.dart';
import 'package:msg_basic/widget/MessageSendingBox.dart';

class SendImageView extends StatefulWidget {
  final File image;
  const SendImageView({required this.image, Key? key}) : super(key: key);

  @override
  State<SendImageView> createState() => _SendImageViewState();
}

class _SendImageViewState extends State<SendImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sem Titulo"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Image.file(widget.image),
              ),
              Column(
                children: [
                  Spacer(),
                  TextField(),
                  MessageSendingBox(sendTextMessage: (String teste){}, sendImageMessage: (){})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
