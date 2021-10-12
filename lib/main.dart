import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:app/app.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await registerParseServer();
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

registerParseServer() async {
  // Initialize parse
  await Parse().initialize(
    'vis',
    'https://parse-server-develop.cloud.sumelongenterprise.com/parse',
    clientKey: 'somesecret',
    debug: true,
    autoSendSessionId: true,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );
  ParseCoreData().registerUserSubClass((username, password, emailAddress,
          {client, debug, sessionToken}) =>
      User(username, password, emailAddress));

  // ParseCoreData().registerSubClass(kIncidentReport, () => IncidentReport());
  // ParseCoreData().registerSubClass(kIncidentReport, () => IncidentCategory());
  // ParseCoreData().registerSubClass(kIncidentReport, () => Institution());
}
