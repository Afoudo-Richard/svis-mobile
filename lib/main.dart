import 'package:app/repository/models/models.dart';
import 'package:app/repository/models/trouble_code.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await registerParseServer();
  tz.initializeTimeZones();
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

  ParseCoreData().registerSubClass(kGroup, () => Group());
  ParseCoreData().registerSubClass(kPermission, () => Permission());
  ParseCoreData().registerSubClass(kProfile, () => Profile());
  ParseCoreData().registerSubClass(kProfileUser, () => ProfileUser());
  ParseCoreData().registerSubClass(kProfileUserTypes, () => ProfileUserTypes());
  ParseCoreData().registerSubClass(kSVISRole, () => SvisRole());
  ParseCoreData().registerSubClass(kProfileUserGroup, () => ProfileUserGroup());
  ParseCoreData().registerSubClass(kEventLog, () => EventLog());
  ParseCoreData().registerSubClass(kVehicle, () => Vehicle());
  ParseCoreData().registerSubClass(kTroubleCode, () => TroubleCode());

}
