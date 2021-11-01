part of 'assign_role_bloc.dart';

abstract class AssignRoleEvent extends Equatable {
  const AssignRoleEvent();

  @override
  List<Object> get props => [];
}

class AssignRoleSelectedRolesChanged extends AssignRoleEvent {
  const AssignRoleSelectedRolesChanged(this.value);

  final List<SvisRole?> value;

  @override
  List<Object> get props => [value];
}

class AssignRoleSelectedUsersChanged extends AssignRoleEvent {
  const AssignRoleSelectedUsersChanged(this.value);

  final List<ProfileUser?> value;

  @override
  List<Object> get props => [value];
}

class CreateAssignRoleSubmitted extends AssignRoleEvent {
  const CreateAssignRoleSubmitted();

  @override
  List<Object> get props => [];
}
