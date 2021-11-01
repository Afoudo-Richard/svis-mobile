import 'dart:async';
import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/base/api_response.dart';
import 'package:app/repository/models/group.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/profile_user_group.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/commons/formz.dart' as fz;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'assign_group_event.dart';
part 'assign_group_state.dart';

class AssignGroupsBloc extends Bloc<AssignGroupsEvent, AssignGroupsState> {
  AssignGroupsBloc({
    List<ProfileUserGroup?> groups = const <ProfileUserGroup?>[],
    List<ProfileUser?> users = const <ProfileUser?>[],
  }) : super(AssignGroupsState(
          groups: Items.dirty(groups),
          users: Items.dirty(users),
        )) {
    on<AssignGroupsSelectedGroupssChanged>(_assignGroupsSelectedGroupssToState);
    on<AssignGroupsSelectedUsersChanged>(_assignGroupsSelectedUsersChanged);
    on<CreateAssignGroupsSubmitted>(_createAssignGroupsSubmittedChanged);
  }

  Future<void> _assignGroupsSelectedUsersChanged(event, emit) async {
    emit(
      state.copyWith(
        users: Items.dirty(event.value),
      ),
    );
  }

  Future<void> _assignGroupsSelectedGroupssToState(event, emit) async {
    emit(
      state.copyWith(
        groups: Items.dirty(event.value),
      ),
    );
  }

  Future<void> _createAssignGroupsSubmittedChanged(
    CreateAssignGroupsSubmitted event,
    Emitter<AssignGroupsState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(submission: fz.FormzSubmission.inProgress()));
      try {
        List<ProfileUserGroup> _groups = state.groups.value
                ?.where((element) => element?.objectId != null)
                .map((e) => e as ProfileUserGroup)
                .toList() ??
            [];
        List<User> _users = state.users.value
                ?.where((element) => element?.user?.objectId != null)
                .map((e) => e?.user as User)
                .toList() ??
            [];
        List<ParseResponse> responses = await Future.wait(_groups.map((item) {
          _users.forEach((element) {
            item.group?.users?.add(element);
          });
          return item.update();
        }).toList());
        List<ApiResponse> _apiResponses =
            responses.map((response) => getApiResponse(response)).toList();

        if (!(_apiResponses
            .map((response) => response.success)
            .contains(false))) {
          emit(state.copyWith(submission: fz.FormzSubmission.success()));
        } else {
          emit(state.copyWith(
            submission: fz.FormzSubmission.failure('error'),
          ));
        }
      } catch (error) {
        emit(state.copyWith(
          submission: fz.FormzSubmission.failure(error.toString()),
        ));
      }
    }
  }
}
