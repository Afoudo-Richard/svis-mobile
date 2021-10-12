import 'dart:async';

import 'package:parse_server_sdk/parse_server_sdk.dart';

enum AuthenticationStatus {
  unknown,
  welcome,
  authenticated,
  registration,
  unauthenticated,
  passwordRecovery,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.welcome;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    var response = await ParseUser(username, password, username).login();
    if (response.success) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      throw response.error?.message ?? 'unable to login';
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
  }) async {
    var user = ParseUser(email, password, email)
      ..set('firstName', firstName)
      ..set('lastName', lastName);
    var response = await user.signUp();
    if (response.success && response.result['code'] == null) {
      return Future.value(response.result);
    } else {
      throw response.error?.message ?? 'unable to login';
    }
  }
}
