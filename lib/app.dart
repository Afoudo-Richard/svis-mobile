import 'package:app/register/register.dart';
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
const kLabelStyle = const TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 9,
);
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
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: kScaffoldBackground,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kAppPrimaryColor,
              displayColor: kAppPrimaryColor,
              fontFamily: 'Poppins',
            ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: kScaffoldBackground,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: kAppPrimaryColor,
                displayColor: kAppPrimaryColor,
                fontFamily: 'Poppins',
              ),
          iconTheme: IconThemeData(color: kAppPrimaryColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(0),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9193AB),
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
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
              case AuthenticationStatus.registration:
                _navigator.pushAndRemoveUntil<void>(
                  RegisterPage.route(),
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
