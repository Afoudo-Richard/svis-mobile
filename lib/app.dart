import 'package:app/welcome/welcome.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/home/home.dart';
import 'package:app/login/login.dart';
import 'package:app/splash/splash.dart';
import 'package:user_repository/user_repository.dart';
import 'package:easy_localization/easy_localization.dart';

const kAppPrimaryColor = const Color(0xFF3F415B);
const kAppAccent = const Color(0xFF2185DC);
const kScaffoldBackground = const Color(0xFFF6F6F6);
const kDangerColor = const Color(0xFFEA265C);
late Size kDeviceSize;

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVIS Mobile',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBackground,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kAppPrimaryColor,
              displayColor: kAppPrimaryColor,
            ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: kScaffoldBackground,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: kAppPrimaryColor,
                displayColor: kAppPrimaryColor,
              ),
          iconTheme: IconThemeData(color: kAppPrimaryColor),
        ),
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            kDeviceSize = MediaQuery.of(context).size;
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.welcome:
                _navigator.pushAndRemoveUntil<void>(
                  WelcomePage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
