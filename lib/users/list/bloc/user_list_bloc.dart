import 'dart:async';

import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_types.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';
part 'user_list_event.dart';

part 'user_list_state.dart';

const _incidentReportsLimit = 20;

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final ProfileUser profile;

  UserListBloc(this.profile) : super(UserListState()) {
    on<UserListFetched>(_onUserListFetched, transformer: droppable());
  }
  void _onUserListFetched(
      UserListFetched event, Emitter<UserListState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == UserListStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: UserListStatus.success,
          profileUsers: items,
          profileUserTypes: items
              .where((element) => element.profileUserType != null)
              .map((item) => item.profileUserType as ProfileUserTypes)
              .toList()
              .unique((x) => x.objectId)
              .toList(),
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.profileUserTypes.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: UserListStatus.success,
              profileUsers: List.of(state.profileUsers)..addAll(items),
              profileUserTypes: List.of(state.profileUserTypes)
                ..addAll(items
                    .where((element) => element.profileUserType != null)
                    .map((item) => item.profileUserType as ProfileUserTypes)
                    .toList()
                    .unique((x) => x.objectId)
                    .toList()),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: UserListStatus.failure));
    }
  }

  Future<List<ProfileUser>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<ProfileUser> query = QueryBuilder<ProfileUser>(ProfileUser());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('Profile', profile.profile);
    query.includeObject(['ProfileUserTypes', 'User']);
    query.setLimit(20);
    return query.find();
  }
}
