import 'dart:typed_data';

import 'package:tribe/core/network/api_client.dart';
import 'package:tribe/features/storage/domain/storage_repo.dart';

class NodeStorageRepo implements StorageRepo{

  final ApiClient api = ApiClient();

  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    // TODO: implement uploadProfileImageMobile
    throw UnimplementedError();
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    // TODO: implement uploadProfileImageWeb
    throw UnimplementedError();
  }

}