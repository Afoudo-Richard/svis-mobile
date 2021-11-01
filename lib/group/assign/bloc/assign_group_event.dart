part of 'assign_group_bloc.dart';

abstract class AssignGroupsEvent extends Equatable {
  const AssignGroupsEvent();

  @override
  List<Object> get props => [];
}

class AssignGroupsSelectedGroupssChanged extends AssignGroupsEvent {
  const AssignGroupsSelectedGroupssChanged(this.value);

  final List<ProfileUserGroup?> value;

  @override
  List<Object> get props => [value];
}

class AssignGroupsSelectedUsersChanged extends AssignGroupsEvent {
  const AssignGroupsSelectedUsersChanged(this.value);

  final List<ProfileUser?> value;

  @override
  List<Object> get props => [value];
}

class CreateAssignGroupsSubmitted extends AssignGroupsEvent {
  const CreateAssignGroupsSubmitted();

  @override
  List<Object> get props => [];
}
