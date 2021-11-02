import 'dart:async';

import 'package:app/repository/models/models.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationProfileChanged>(_onAuthenticationProfileChanged);
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.passwordReset:
        return emit(const AuthenticationState.passwordReset());
      case AuthenticationStatus.welcome:
        if (state.status == AuthenticationStatus.authenticated) {
          return emit(state.user?.objectId != null
              ? state
              : const AuthenticationState.unauthenticated());
        } else {
          return emit(const AuthenticationState.welcome());
        }
      case AuthenticationStatus.registration:
        return emit(const AuthenticationState.registration());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        final profiles = await _tryGetProfiles();
        final profileUserTypes = await _tryGetProfileUserType();

        return emit(user != null
            ? AuthenticationState.authenticated(
                user: user,
                profileUsers: profiles,
                profile: profiles.first,
                profileUserTypes: profileUserTypes,
              )
            : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationProfileChanged(
    AuthenticationProfileChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.profile != null) {
      emit(
        AuthenticationState.authenticated(
          user: state.user,
          profileUsers: state.profileUsers,
          profile: event.profile,
          profileUserTypes: state.profileUserTypes,
        ),
      );
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<List<ProfileUser>> _tryGetProfiles() async {
    QueryBuilder<ProfileUser> query = QueryBuilder<ProfileUser>(ProfileUser());
    query.whereEqualTo('User', await ParseUser.currentUser());
    query.includeObject(['User', 'ProfileUserTypes', 'Profile']);
    return query.find();
  }

  Future<List<ProfileUserTypes>> _tryGetProfileUserType() async {
    QueryBuilder<ProfileUserTypes> query =
        QueryBuilder<ProfileUserTypes>(ProfileUserTypes());
    return query.find();
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthenticationState.fromJson(json);
    } catch (e, s) {
      // FirebaseCrashlytics.instance.recordError(e, s,
      //     reason: 'Unable to convert json to AuthenticationState');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    try {
      return state.toJson();
    } catch (e, s) {
      // FirebaseCrashlytics.instance
      //     .recordError(e, s, reason: 'Unable to convert state to json');
      return null;
    }
  }
}
