import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaPreferences {

  static Future<File?> pickMedia({
    required bool isGallery,
    required Future<File?> Function(File file) cropImage,
  }) async {
    final ImagePicker _picker = ImagePicker();

    final source = isGallery ? ImageSource.gallery : ImageSource.camera;

    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile == null) return null;

    // ignore: unnecessary_null_comparison
    if (cropImage == null) {
      return File(pickedFile.path);
    } else {
      final file = File(pickedFile.path);

      return cropImage(file);
    }
  }
}
