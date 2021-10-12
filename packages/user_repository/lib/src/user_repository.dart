import 'dart:async';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'models/models.dart';

class UserRepository {
  Future<User?> getUser() async {
    return await ParseUser.currentUser() as User?;
  }
}
