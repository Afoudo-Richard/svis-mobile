import 'dart:async';

import 'package:parse_server_sdk/parse_server_sdk.dart';

enum AuthenticationStatus {
  unknown,
  welcome,
  authenticated,
  registration,
  unauthenticated,
  passwordReset,
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

  Future<ParseResponse> resetPassword({
    required String username,
  }) async {
    final ParseUser user = ParseUser(username.toLowerCase(), '', username);
    return await user.requestPasswordReset();
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
    final ParseCloudFunction function = ParseCloudFunction('register');
    final Map<String, String> params = <String, String>{
      'email': email,
      'username': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
    ParseResponse response = await function.execute(parameters: params);
    if (response.success && response.result['code'] == null) {
      return Future.value(response.result);
    } else {
      throw response.error?.message ?? 'unable to login';
    }
  }
}
