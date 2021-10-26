import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  ProfileUser user;
  RoleBloc({required this.user}) : super(RoleState()) {
    on<FetchRoleEvent>(_onRoleListFetched);
  }
  void _onRoleListFetched(FetchRoleEvent event, Emitter<RoleState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == RoleStatus.initial) {
        final items = await _fetchItems();
        return emit(state.copyWith(
          status: RoleStatus.success,
          items: items,
          hasReachedMax: true,
        ));
      }

      final items = await _fetchItems(state.items.length);
      emit(items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: RoleStatus.success,
              items: List.of(state.items)..addAll(items),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: RoleStatus.failure));
    }
  }

  Future<List<SvisRole>> _fetchItems([int startIndex = 0]) async {
    QueryBuilder<SvisRole> query = QueryBuilder<SvisRole>(SvisRole());
    query.setAmountToSkip(startIndex);
    query.whereEqualTo('Profile', user.profile);
    query.whereContainedIn('Users', [await ParseUser.currentUser()]);
    query.includeObject(['Permissions']);
    return query.find();
  }
}
