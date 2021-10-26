part of 'role_bloc.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object> get props => [];
}

class FetchRoleEvent extends RoleEvent {}

class TextChanged extends RoleEvent {
  const TextChanged({required this.text});
  final String text;

  @override
  List<Object> get props => [text];
}
