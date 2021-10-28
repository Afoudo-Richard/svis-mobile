part of 'assign_role_bloc.dart';

class AssignRoleState extends Equatable
    with fz.FormzMixin<String, ParseObject> {
  final Items<SvisRole?> roles;
  final Items<ProfileUser?> users;

  final fz.FormzSubmission<String, ParseObject> _submission;

  AssignRoleState({
    this.roles = const Items.pure(),
    this.users = const Items.pure(),
    fz.FormzSubmission<String, ParseObject> status =
        const fz.FormzSubmission.pure(),
  }) : _submission = status;

  AssignRoleState copyWith({
    Items<SvisRole?>? roles,
    Items<ProfileUser?>? users,
    fz.FormzSubmission<String, ParseObject>? submission,
  }) {
    return AssignRoleState(
      roles: roles ?? this.roles,
      users: users ?? this.users,
      status: submission ?? this._submission,
    );
  }

  @override
  List<Object> get props => [
        roles,
        users,
        _submission,
      ];

  @override
  List<fz.FormzInput> get inputs => [
        roles,
        users,
      ];

  @override
  fz.FormzSubmission<String, ParseObject> get submission => _submission;
}
