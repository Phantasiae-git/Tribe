import 'dart:convert';

import 'package:tribe/core/network/api_client.dart';
import 'package:tribe/features/matchmaking/domain/entities/tribe_form.dart';
import 'package:tribe/features/matchmaking/domain/repos/tribe_form_repo.dart';

class NodeTribeFormRepo implements TribeFormRepo{

  final ApiClient api = ApiClient();

  @override
  Future<void> submitForm(TribeForm form) async {
    try {
      print(form.toJson());
      final res = await api.post(
        "matchmaking/submitForm",
        body: form.toJson(),
      );
      final body = jsonDecode(res.body);

      if (res.statusCode == 500) {
        throw Exception(body['error']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TribeForm?> unsubmitForm() async {
    // TODO: implement unsubmitForm
    throw UnimplementedError();
  }

}