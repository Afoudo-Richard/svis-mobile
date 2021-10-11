import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:app/app.dart';
import 'package:user_repository/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('fr', 'FR'),
      Locale('de', 'DE'),
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    child: App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  ));
}
