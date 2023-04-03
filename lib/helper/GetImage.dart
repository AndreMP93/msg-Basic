import 'dart:io';
import 'package:image_picker/image_picker.dart';

class GetImage{
  static Future<File?> fromGallery() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static Future<File?> fromCamera() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}