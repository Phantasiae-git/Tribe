import 'dart:typed_data';

abstract class StorageRepo {
  Future<String?> uploadProfileImageMobile(String path, String fileName);//for mobile, path is enough
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);//web needs extra fileBytes to upload
}