import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return null;

    final appDir = await getApplicationDocumentsDirectory();

    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}_${image.name}";

    final savedImage = File(
      "${appDir.path}/$fileName",
    );

    await File(image.path).copy(savedImage.path);

    return savedImage.path;
  }
}