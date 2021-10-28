import 'dart:async';
import 'package:app/commons/forms/forms.dart';
import 'package:app/repository/base/api_response.dart';
import 'package:app/repository/models/profile_user.dart';
import 'package:app/repository/models/svis_role.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/commons/formz.dart' as fz;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:user_repository/user_repository.dart';

part 'assign_role_event.dart';
part 'assign_role_state.dart';

class AssignRoleBloc extends Bloc<AssignRoleEvent, AssignRoleState> {
  AssignRoleBloc({
    List<SvisRole?> roles = const <SvisRole?>[],
    List<ProfileUser?> users = const <ProfileUser?>[],
  }) : super(AssignRoleState(
          roles: Items.dirty(roles),
          users: Items.dirty(users),
        )) {
    on<AssignRoleSelectedRolesChanged>(_assignRoleSelectedRolesToState);
    on<AssignRoleSelectedUsersChanged>(_assignRoleSelectedUsersChanged);
    on<CreateAssignRoleSubmitted>(_createAssignRoleSubmittedChanged);
  }

  Future<void> _assignRoleSelectedUsersChanged(event, emit) async {
    emit(
      state.copyWith(
        users: Items.dirty(event.value),
      ),
    );
  }

  Future<void> _assignRoleSelectedRolesToState(event, emit) async {
    emit(
      state.copyWith(
        roles: Items.dirty(event.value),
      ),
    );
  }

  Future<void> _createAssignRoleSubmittedChanged(
    CreateAssignRoleSubmitted event,
    Emitter<AssignRoleState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(submission: fz.FormzSubmission.inProgress()));
      try {
        List<SvisRole> _roles = state.roles.value
                ?.where((element) => element?.objectId != null)
                .map((e) => e as SvisRole)
                .toList() ??
            [];
        List<User> _users = state.users.value
                ?.where((element) => element?.user?.objectId != null)
                .map((e) => e?.user as User)
                .toList() ??
            [];
        List<ParseResponse> responses = await Future.wait(_roles.map((item) {
          _users.forEach((element) {
            item.users?.add(element);
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
            submission:
                fz.FormzSubmission.failure('error'),
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
