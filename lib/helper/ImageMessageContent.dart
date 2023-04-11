import 'dart:io';

class ImageMessageContent{
  String text;
  File image;
  bool isSeleted = false;
  ImageMessageContent({required this.text, required this.image});
}