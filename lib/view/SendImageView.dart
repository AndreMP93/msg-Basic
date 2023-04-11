import 'dart:io';
import 'package:flutter/material.dart';
import 'package:msg_basic/helper/GetImage.dart';
import 'package:msg_basic/helper/ImageMessageContent.dart';
import 'package:msg_basic/resources/AppColors.dart';

class SendImageView extends StatefulWidget {
  final File image;
  final Function(File, String) sendImageMessage;
  final List<ImageMessageContent> imageMessageContent;
  const SendImageView({
    required this.image,
    required this.sendImageMessage,
    required this.imageMessageContent,
    Key? key}) : super(key: key);

  @override
  State<SendImageView> createState() => _SendImageViewState();
}

class _SendImageViewState extends State<SendImageView> {

  final TextEditingController _textMessageController = TextEditingController();
  late File _image;
  String _textMEssage = "";
  int _indexImageMessageContent = 0;
  @override
  void initState() {
    super.initState();
    _image = widget.image;
    widget.imageMessageContent.add(ImageMessageContent(text: "", image: widget.image));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width * 0.25,
              minHeight: MediaQuery.of(context).size.width * 0.25,
            ),
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: Image.file(_image),
            ),
          ),
        ),

        Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.transparent,
          ),
          body: Column(
            children: [
              const Spacer(),
              (widget.imageMessageContent.length<2)
                  ? Container()
                  : Center(child: Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.imageMessageContent.length,
                      itemBuilder: (context, index){
                        _indexImageMessageContent = index;
                        return GestureDetector(
                          onTap: (){
                            _textMessageController.text = widget.imageMessageContent[index].text;
                            widget.imageMessageContent[index].text = _textMEssage;
                            setState(() {
                              for(var item in widget.imageMessageContent){
                                item.isSeleted = false;
                              }
                              widget.imageMessageContent[index].isSeleted = true;
                              _image = widget.imageMessageContent[index].image;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 1),
                                color: Colors.black,
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: MediaQuery.of(context).size.width * 0.15,
                                child: Image.file(widget.imageMessageContent[index].image),
                              ),
                              (widget.imageMessageContent[index].isSeleted)
                              ?GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(index < widget.imageMessageContent.length-1){
                                      _image = widget.imageMessageContent[index+1].image;
                                    }else{
                                      _image = widget.imageMessageContent[index-1].image;
                                    }
                                    widget.imageMessageContent.removeAt(index);


                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                ),
                              )
                              :Container()
                            ],
                          ),
                        );
                      }
                  ),
              ),),

              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextField(
                          controller: _textMessageController,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 20),
                          onChanged: (value){
                            widget.imageMessageContent[_indexImageMessageContent].text = value;
                          },
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.fromLTRB(32, 8, 0, 8),
                              hintText: "Coloque uma legenda!",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)
                              ),
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.add_photo_alternate, color: AppColors.primaryColor,),
                                onPressed: () async {
                                  File? image = await GetImage.fromGallery();
                                  if(image!= null){
                                    setState(() {
                                      for(var i in widget.imageMessageContent){
                                        i.isSeleted = false;
                                      }
                                      ImageMessageContent item = ImageMessageContent(text: "", image: image);
                                      item.isSeleted = true;
                                      widget.imageMessageContent.add(item);
                                      _image = item.image;
                                    });
                                  }
                                },
                              )
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                        backgroundColor: AppColors.buttonColor,
                        mini: true,
                        onPressed: () async {
                          for(var item in widget.imageMessageContent){
                            widget.sendImageMessage(item.image, item.text);
                          }
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.send, color: Colors.white,)
                    )
                  ],
                ),
              ),

            ],
          ),
        )
      ],
    );
  }
}
